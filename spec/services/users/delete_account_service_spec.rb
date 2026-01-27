# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::DeleteAccountService do
  describe ".call" do
    let!(:user) { create(:user) }
    let!(:delete_reason) { create(:delete_reason) }

    context "with valid uuid and delete_reason_id" do
      it "returns success and deletes user and creates user_delete_reason" do
        expect {
          result = described_class.call(uuid: user.uuid, delete_reason_id: delete_reason.id)
          expect(result.success?).to be true
          expect(result.user).to be_a(User)
        }.to change { User.count }.by(-1)
         .and change { UserDeleteReason.count }.by(1)
      end
    end

    context "with invalid uuid" do
      it "returns failure and does not delete any user" do
        expect {
          result = described_class.call(uuid: "invalid-uuid", delete_reason_id: delete_reason.id)
          expect(result.success?).to be false
          expect(result.user.errors[:uuid]).to be_present
        }.not_to change { User.count }
      end
    end

    context "with blank delete_reason_id" do
      it "returns failure and does not delete any user" do
        expect {
          result = described_class.call(uuid: user.uuid, delete_reason_id: "")
          expect(result.success?).to be false
          expect(result.user.errors[:base]).to be_present
        }.not_to change { User.count }
      end
    end
  end
end
