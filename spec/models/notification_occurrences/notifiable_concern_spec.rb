# frozen_string_literal: true

require "rails_helper"

RSpec.describe NotificationOccurrences::NotifiableConcern, type: :model do
  describe "#after_commit, notify_occurence_async" do
    it "increases NotificationOccurrenceJob by 1" do
      expect { create(:notification_occurrence) }.to change { NotificationOccurrenceJob.jobs.size }.by(1)
    end
  end

  describe "#update_progress_status" do
    let!(:notification_occurrence) { create(:notification_occurrence, success_count: 0, failure_count: 0, token_count: 1) }
    let!(:registered_token) { create(:registered_token) }

    context "response success" do
      before {
        notification_occurrence.update_progress_status({ status_code: 200 }, registered_token)
      }

      it "increases success_count" do
        expect(notification_occurrence.success_count).to eq(1)
      end

      it "set status delivered" do
        expect(notification_occurrence.status).to eq("delivered")
      end
    end

    context "response failure" do
      it "increases failure_count" do
        notification_occurrence.update_progress_status({ status_code: 400, body: "The registration token is not a valid FCM registration token" }, registered_token)

        expect(notification_occurrence.failure_count).to eq(1)
      end
    end
  end

  describe "#notify_all_token_async" do
    let!(:notification_occurrence) { create(:notification_occurrence, success_count: 0, failure_count: 0, token_count: 0) }
    let!(:registered_token) { create(:registered_token) }

    it "enqueues one push job and updates token_count" do
      expect { notification_occurrence.notify_all_token_async }.to change { PushNotificationJob.jobs.size }.by(1)
      expect(notification_occurrence.reload.token_count).to eq(1)
    end
  end

  describe "#finished?" do
    it "returns true" do
      notification_occurrence = build(:notification_occurrence, success_count: 10, failure_count: 5, token_count: 15)
      expect(notification_occurrence.finished?).to be_truthy
    end

    it "returns false" do
      notification_occurrence = build(:notification_occurrence, success_count: 1, failure_count: 5, token_count: 15)
      expect(notification_occurrence.finished?).to be_falsey
    end
  end
end
