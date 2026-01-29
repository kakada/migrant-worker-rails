# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V2::DeleteReasonsController", type: :request do
  describe "GET #index" do
    let(:api_key) { create(:api_key) }
    let(:headers) { { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" } }

    before do
      create(:delete_reason, name_km: "មិនមានព័ត៌មាន", name_en: "No information")
      create(:delete_reason, name_km: "បារម្ភ", name_en: "Worried about privacy")
    end

    it "returns a list of delete_reasons" do
      get "/api/v2/delete_reasons", headers: headers

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)["data"]
      expect(json_response.length).to eq(2)
      expect(json_response.first["name_km"]).to be_present
      expect(json_response.first["name_en"]).to be_present
    end
  end
end
