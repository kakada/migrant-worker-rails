# frozen_string_literal: true

module Users
  class DeletionsController < ApplicationController
    skip_before_action :authenticate_account!
    before_action :verify_recaptcha_token, only: :create
    before_action :load_reasons, only: %i[new create]

    layout "sidebar_less"

    def index
      redirect_to new_users_deletion_path
    end

    def show
      # thank-you page
    end

    def new
      @user = User.new
    end

    def create
      result = Users::DeleteAccountService.call(uuid: user_params[:uuid], delete_reason_id: user_params[:delete_reason_id])
      @user = result.user

      if result.success?
        flash[:notice] = t("users.deletions.success")
        redirect_to users_deletion_path("thank-you")
      else
        flash.now[:alert] ||= t("users.deletions.failed")
        render :new
      end
    end

    private
      def load_reasons
        @delete_reasons = DeleteReason.order(:display_order)
      end

      def verify_recaptcha_token
        return if Rails.env.development? || verify_recaptcha

        @user = User.new
        load_reasons
        flash.now[:alert] = t("users.deletions.recaptcha_failed")
        render :new
      end

      def user_params
        params.require(:user).permit(:uuid, :delete_reason_id)
      end
  end
end
