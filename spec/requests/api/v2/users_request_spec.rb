# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V2::UsersController, type: :request do
  let(:api_key) { ApiKey.create }
  let(:headers) { { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" } }

  describe "POST user#create" do
    let(:params) {
      { "user"=>'{"uuid":"a86239a8-f8b2-4702-9590-dd15a189d40d","full_name":"Sokra","age":"30","sex":"female","phone_number":"012 333 444","voice":""}' }
    }

    it "create a new user" do
      expect {
        post "/api/v2/users", headers: headers, params: params
      }.to change(User, :count).by(1)
    end
  end

  describe "DELETE user#destroy" do
    let!(:user) { create(:user) }
    let!(:delete_reason) { create(:delete_reason) }

    context "with valid delete_reason_id" do
      it "soft deletes the user" do
        expect {
          delete "/api/v2/users/#{user.uuid}", headers: headers, params: { delete_reason_id: delete_reason.id }
        }.to change { User.count }.by(-1)
           .and change { UserDeleteReason.count }.by(1)

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["message"]).to eq("User deleted successfully")
      end
    end

    context "without delete_reason_id" do
      it "returns an error" do
        delete "/api/v2/users/#{user.uuid}", headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to be_present
      end

      it "does not delete the user" do
        expect {
          delete "/api/v2/users/#{user.uuid}", headers: headers
        }.not_to change { User.count }
      end
    end
  end
end
