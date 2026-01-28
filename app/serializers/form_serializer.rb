# frozen_string_literal: true

# == Schema Information
#
# Table name: forms
#
#  id           :bigint           not null, primary key
#  code         :string
#  name         :string
#  form_type    :string
#  version      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :string
#  audio        :string
#  published_at :datetime
#  description  :text
#
class FormSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :audio_url, :image_url

  has_many :questions

  def image_url
    object.image_url if object.image.present?
  end

  def audio_url
    object.audio_url if object.audio.present?
  end
end
