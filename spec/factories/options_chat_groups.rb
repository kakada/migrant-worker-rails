# frozen_string_literal: true

# == Schema Information
#
# Table name: options_chat_groups
#
#  id            :uuid             not null, primary key
#  option_id     :integer
#  chat_group_id :uuid
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :options_chat_group do
    option_id { 1 }
    chat_group_id { SecureRandom.uuid }
  end
end
