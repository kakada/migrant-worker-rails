# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserDeletionJob, type: :job do
  describe "#perform" do
    let!(:user) { create(:user) }

    context "when user is soft deleted" do
      before do
        user.destroy
      end

      it "permanently deletes the user" do
        expect {
          described_class.new.perform(user.id)
        }.to change { User.with_deleted.count }.by(-1)
      end

      it "removes the user completely from database" do
        described_class.new.perform(user.id)
        expect(User.with_deleted.find_by(id: user.id)).to be_nil
      end
    end

    context "when user is not deleted" do
      it "does not delete the user" do
        expect {
          described_class.new.perform(user.id)
        }.not_to change { User.count }
      end
    end

    context "when user does not exist" do
      it "does not raise an error" do
        expect {
          described_class.new.perform(999999)
        }.not_to raise_error
      end
    end
  end
end
