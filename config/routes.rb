# frozen_string_literal: true

require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do
  use_doorkeeper do
    controllers token_info: "token_info"
  end

  devise_for :accounts, path: "/", controllers: { confirmations: "confirmations", omniauth_callbacks: "accounts/omniauth_callbacks" }
  # https://github.com/plataformatec/devise/wiki/How-To:-Override-confirmations-so-users-can-pick-their-own-passwords-as-part-of-confirmation-activation
  as :account do
    match "/confirmation" => "confirmations#update", via: :put, as: :update_account_confirmation
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "users#index"

  get "/terms-and-conditions", to: "terms_and_conditions#index"
  get "/privacy-policy", to: "privacy_policy#index"

  resource :locale, only: :update

  resources :accounts do
    member do
      post :resend_confirmation
      put :archive
      put :restore
      put :enable_dashboard
      put :disable_dashboard
    end
  end

  namespace :users do
    resources :deletions, only: [:new, :create, :index, :show]
  end

  resources :users do
    get :download, on: :collection

    resources :surveys, only: [:index, :show], module: :users
  end

  resource :about, only: [:show]

  resources :categories
  resources :departures
  resources :safeties
  resources :category_images, only: [:create, :destroy]
  resources :notifications do
    put :release, on: :member
    put :cancel, on: :member
  end
  resources :notification_importers
  resources :videos
  resources :video_authors
  resources :video_tags
  resources :video_importers

  resources :institutions do
    member do
      delete :delete_logo
      delete :delete_audio
    end
  end

  # User story
  resources :story_forms do
    put :publish, on: :member
  end

  # Survey
  resources :survey_forms

  # Telegram bot
  get "helps/how-to-connect-telegram-bot", to: "helps#telegram_bot"

  resource :telegram_bot, only: [:show] do
    put :upsert, on: :collection
  end

  resources :chat_groups, only: [:index]

  resources :pages

  # Api
  namespace :api do
    namespace :integration do
      # Telegram
      constraints Whitelist do
        telegram_webhook Api::Integration::TelegramWebhooksController
      end
    end

    namespace :v1 do
      resources :users, only: [:create]

      resources :countries, only: [:index] do
        resources :institutions, only: [:index]
        resources :country_institutions, only: :index
      end

      resources :pdfs, only: [] do
        get :download, on: :collection
      end

      resources :categories
      resources :departures, controller: :categories, type: "Categories::Departure", only: [:index, :show]
      resources :safeties, controller: :categories, type: "Categories::Safety", only: [:index, :show]

      resources :forms, only: [:index, :show]
      resources :quizzes, only: [:create]
      resources :answers, only: [:update]
      resource  :registered_tokens, only: [:update]
    end

    namespace :v2 do
      resources :users, only: [:create, :destroy]

      resources :countries, only: [:index] do
        resources :institutions, only: [:index]
        resources :country_institutions, only: :index
      end

      resources :pdfs, only: [] do
        get :download, on: :collection
      end

      resources :categories
      resources :departures, controller: :categories, type: "Categories::Departure", only: [:index, :show]
      resources :safeties, controller: :categories, type: "Categories::Safety", only: [:index, :show]

      resources :forms, only: [:index, :show]
      resources :surveys, only: [:create]
      resources :survey_answers, only: [:update]
      resource  :registered_tokens, only: [:update]

      resources :videos, only: [:index]
      resources :survey_forms, only: [:show]
      resources :visits, only: [:create]
      resources :delete_reasons, only: [:index]
    end
  end

  if Rails.env.production?
    # Sidekiq
    authenticate :account, lambda { |u| u.system_admin? } do
      mount Sidekiq::Web => "/sidekiq"
    end
  else
    mount Sidekiq::Web => "/sidekiq"
  end
end
