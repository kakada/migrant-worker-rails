# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "POST user#create" do
    let(:api_key) { ApiKey.create! }
    let(:attributes) {
      { "user"=>'{"uuid":"a86239a8-f8b2-4702-9590-dd15a189d40d","full_name":"Sokra","age":"30","sex":"female","phone_number":"012 333 444","voice":""}' }
    }

    context "success" do
      before(:each) do
        request.headers["Authorization"] = "Token #{api_key.access_token}"
      end

      it "creates a new user" do
        expect { post :create, params: attributes }.to change(User, :count).by(1)
      end
    end

    context "fail" do
      it "do not create a new user" do
        expect { post :create, params: attributes }.to change(User, :count).by(0)
      end
    end
  end
end
