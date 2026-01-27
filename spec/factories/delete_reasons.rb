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
FactoryBot.define do
  factory :delete_reason do
    name_km { "មូលហេតុសាកល្បង" }
    name_en { "Test Reason" }
    display_order { 1 }
  end
end
