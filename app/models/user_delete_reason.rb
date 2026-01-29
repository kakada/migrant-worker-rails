# frozen_string_literal: true

# == Schema Information
#
# Table name: user_delete_reasons
#
#  id               :bigint           not null, primary key
#  user_id          :bigint
#  delete_reason_id :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class UserDeleteReason < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :delete_reason

  # Validations
  validates :user_id, presence: true
  validates :delete_reason_id, presence: true
end
