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
require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:user_delete_reasons).with_foreign_key(:user_id) }
  end

  describe "#destroy_with_reason" do
    let!(:user) { create(:user) }
    let!(:delete_reason) { create(:delete_reason) }

    context "with valid delete_reason_id" do
      it "creates a user delete reason and soft deletes the user" do
        expect {
          user.destroy_with_reason(delete_reason.id)
        }.to change { UserDeleteReason.count }.by(1)
         .and change { User.count }.by(-1)

        expect(user.reload.deleted?).to be true
        expect(user.user_delete_reasons.last.delete_reason_id).to eq(delete_reason.id)
      end

      it "schedules the user for real deletion" do
        allow(UserDeletionJob).to receive(:set).and_call_original
        user.destroy_with_reason(delete_reason.id)
        expect(UserDeletionJob).to have_received(:set)
      end
    end

    context "without delete_reason_id" do
      it "returns false and adds error" do
        result = user.destroy_with_reason(nil)
        expect(result).to be false
        expect(user.errors[:reason]).to include("cannot be blank")
      end

      it "does not delete the user" do
        expect {
          user.destroy_with_reason(nil)
        }.not_to change { User.count }
      end
    end
  end

  describe "soft delete" do
    let(:user) { create(:user) }

    it "soft deletes the user" do
      user.destroy
      expect(user.deleted?).to be true
      expect(User.count).to eq(0)
      expect(User.with_deleted.count).to eq(1)
    end
  end
end
