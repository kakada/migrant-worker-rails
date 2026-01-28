# frozen_string_literal: true

# == Schema Information
#
# Table name: institutions
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  kind          :integer          default(2)
#  address       :text             default("")
#  logo          :string
#  audio         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  code          :string
#  name_km       :string
#  display_order :integer
#
class InstitutionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :address, :logo_url, :audio_url, :name_km, :display_order

  has_many :contacts
  has_many :country_institutions

  def logo_url
    object.logo_url if object.logo.present?
  end

  def audio_url
    object.audio_url if object.audio.present?
  end
end
