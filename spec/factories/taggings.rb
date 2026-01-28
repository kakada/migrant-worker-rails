# frozen_string_literal: true

# == Schema Information
#
# Table name: taggings
#
#  id            :bigint           not null, primary key
#  tag_id        :uuid
#  taggable_id   :string
#  taggable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :tagging do
    tag_id { SecureRandom.uuid }
    taggable_id { "1" }
    taggable_type { "SampleType" }
  end
end
