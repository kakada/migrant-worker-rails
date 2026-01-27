# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  uuid          :string
#  full_name     :string
#  sex           :string
#  age           :string
#  audio         :string
#  registered_at :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#
class User < ApplicationRecord
  audited
  include Users::ScheduleDeletionConcern

  # Constant
  GENDERS = %w(male female other)

  # Mount file
  mount_uploader :audio, AudioUploader

  # Association
  has_many :surveys, foreign_key: :user_uuid, primary_key: :uuid

  # Scope
  default_scope { order(registered_at: :desc) }

  # Callback
  before_create :set_uuid

  # Instance method
  def profile_html
    "#{I18n.t('users.username')}: <b>#{full_name}</b>, #{I18n.t('users.gender')}: <b>#{sex}</b>, #{I18n.t('users.age')}: <b>#{age}</b>"
  end

  # Class method
  def self.filter(params = {})
    scope = all
    scope = scope.where("LOWER(full_name) LIKE ?", "%#{params[:full_name].downcase.strip}%") if params[:full_name].present?
    scope = scope.where("registered_at BETWEEN ? AND ?", DateTime.parse(params[:start_date]).beginning_of_day, DateTime.parse(params[:end_date]).end_of_day) if params[:start_date].present? && params[:end_date].present?
    scope = scope.where("age BETWEEN ? AND ?", params[:start_age], params[:end_age]) if params[:start_age].present? && params[:end_age].present?
    scope = scope.where("LOWER(sex) IN (?)", params[:genders].map(&:downcase)) if params[:genders].present?
    scope
  end
end
