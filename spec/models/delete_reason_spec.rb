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
require "rails_helper"

RSpec.describe DeleteReason, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name_km) }
    it { should validate_presence_of(:name_en) }
  end

  describe "associations" do
    it { should have_many(:user_delete_reasons) }
  end

  describe "soft delete" do
    let(:delete_reason) { create(:delete_reason) }

    it "soft deletes the delete_reason" do
      delete_reason.destroy
      expect(delete_reason.deleted?).to be true
      expect(DeleteReason.count).to eq(0)
      expect(DeleteReason.with_deleted.count).to eq(1)
    end
  end
end
