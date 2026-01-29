# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  uuid          :string
#  full_name     :string
#  sex           :string
#  age           :string
#  audio         :string
#  registered_at :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#
FactoryBot.define do
  factory :user do
    uuid          { SecureRandom.uuid }
    full_name     { FFaker::Name.name }
    age           { (18..60).to_a.sample }
    sex           {  %w(female male other).sample }
  end
end
