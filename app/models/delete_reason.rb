# frozen_string_literal: true

# == Schema Information
#
# Table name: delete_reasons
#
#  id            :uuid             not null, primary key
#  name_km       :string
#  name_en       :string
#  display_order :integer
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class DeleteReason < ApplicationRecord
  acts_as_paranoid

  # Validations
  validates :name_km, presence: true
  validates :name_en, presence: true

  # Associations
  has_many :user_delete_reasons, dependent: :destroy
end
