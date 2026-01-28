# frozen_string_literal: true

# == Schema Information
#
# Table name: batches
#
#  id             :uuid             not null, primary key
#  code           :string
#  total_count    :integer          default(0)
#  valid_count    :integer          default(0)
#  new_count      :integer          default(0)
#  province_count :integer          default(0)
#  reference      :string
#  creator_id     :integer
#  type           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :batch do
    code { "BATCH001" }
    total_count { 100 }
    valid_count { 90 }
    new_count { 80 }
    province_count { 70 }
    reference { "Initial batch upload" }
    creator_id { 1 }
    type { "UserBatch" }
  end
end
