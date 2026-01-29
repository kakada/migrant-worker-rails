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
FactoryBot.define do
  factory :user_delete_reason do
    association :user
    association :delete_reason
  end
end
