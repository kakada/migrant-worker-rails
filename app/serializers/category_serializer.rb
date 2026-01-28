# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id             :bigint           not null, primary key
#  name           :string
#  image          :string
#  audio          :string
#  description    :text
#  type           :string
#  parent_id      :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  last           :boolean          default(FALSE)
#  uuid           :string
#  is_video       :boolean
#  hint           :string
#  hint_image     :string
#  hint_audio     :string
#
class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image_url, :audio_url, :parent_id,
             :uuid, :leaf, :lft, :rgt, :type, :is_video, :hint, :hint_image_url,
             :hint_audio_url, :updated_at

  def leaf
    object.leaf?
  end

  def image_url
    object.image_url if object.image.present?
  end

  def audio_url
    object.audio_url if object.audio.present?
  end

  def hint_audio_url
    object.hint_audio_url if object.hint_audio.present?
  end

  def hint_image_url
    object.hint_image_url if object.hint_image.present?
  end
end
