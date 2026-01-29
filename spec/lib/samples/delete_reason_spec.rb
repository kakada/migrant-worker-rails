# frozen_string_literal: true

require "rails_helper"
require "samples/delete_reason"

RSpec.describe Samples::DeleteReason do
  describe ".load" do
    it "loads delete_reasons from CSV file" do
      expect {
        described_class.load
      }.to change { DeleteReason.count }.by_at_least(5)
    end

    it "creates delete_reasons with correct attributes" do
      described_class.load

      delete_reason = DeleteReason.first
      expect(delete_reason).to be_present
      expect(delete_reason.name_km).to be_present
      expect(delete_reason.name_en).to be_present
      expect(delete_reason.display_order).to be_present
    end
  end
end
