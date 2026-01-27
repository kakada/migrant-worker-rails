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
require "rails_helper"

RSpec.describe UserDeleteReason, type: :model do
  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:delete_reason_id) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:delete_reason) }
  end
end
