# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id             :uuid             not null, primary key
#  name           :string
#  taggings_count :integer
#  display_order  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :tag do
    name { "Sample Tag" }
    taggings_count { 0 }
    display_order { 1 }
  end
end
