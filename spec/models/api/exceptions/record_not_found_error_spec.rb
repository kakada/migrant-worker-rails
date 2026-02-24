# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::Exceptions::RecordNotFoundError do
  def parsed_error(exception)
    JSON.parse(exception.to_json).fetch("errors").first
  end

  it "has status 404" do
    exception = described_class.new("Couldn't find User", {})
    expect(exception.status).to eq(404)
  end

  it "serializes a JSON:API-ish error" do
    exception = described_class.new("Couldn't find User with 'id'=123", { id: "123" })
    error = parsed_error(exception)

    expect(error["title"]).to eq("Record Not Found")
    expect(error["code"]).to eq(404)
    expect(error["status"]).to eq("404")
    expect(error["detail"]).to eq("The record identified by 123 could not be found.")
  end

  context "when the identifier comes from params" do
    it "uses params[:id] for RESTful routes" do
      uuid = SecureRandom.uuid
      exception = described_class.new("Couldn't find User", { id: uuid })
      expect(parsed_error(exception)["detail"]).to eq("The record identified by #{uuid} could not be found.")
    end

    it "keeps legacy id strings like '123&456' as a single string" do
      exception = described_class.new("Couldn't find User", { id: "123&456" })
      expect(parsed_error(exception)["detail"]).to eq("The record identified by 123&456 could not be found.")
    end

    it "keeps malformed legacy IDs like '<uuid>&delete_reason_id=123' as a single string" do
      uuid = SecureRandom.uuid
      exception = described_class.new("Couldn't find User", { id: "#{uuid}&delete_reason_id=123" })
      expect(parsed_error(exception)["detail"]).to eq("The record identified by #{uuid}&delete_reason_id=123 could not be found.")
    end

    it "uses the last value when multiple params exist (nested routes)" do
      exception = described_class.new("Couldn't find Post", { user_id: "42", id: "7" })
      expect(parsed_error(exception)["detail"]).to eq("The record identified by 7 could not be found.")
    end
  end

  context "when params[:id] is missing" do
    it "falls back to params[:user_id] for nested routes" do
      exception = described_class.new("Couldn't find Post", { user_id: "42" })
      expect(parsed_error(exception)["detail"]).to eq("The record identified by 42 could not be found.")
    end
  end

  context "when no identifier can be extracted" do
    it "uses 'unknown'" do
      exception = described_class.new("Couldn't find User", nil)
      expect(parsed_error(exception)["detail"]).to eq("The record identified by unknown could not be found.")
    end
  end
end
