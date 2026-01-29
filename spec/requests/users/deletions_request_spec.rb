# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users::DeletionsController", type: :request do
  describe "GET #new" do
    it "renders the deletion form" do
      get new_users_deletion_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    let!(:user) { create(:user) }
    let!(:delete_reason) { create(:delete_reason) }

    before do
      allow(Rails.env).to receive(:development?).and_return(true)
    end

    context "with valid parameters" do
      let(:params) {
        {
          user: {
            uuid: user.uuid,
            delete_reason_id: delete_reason.id
          }
        }
      }

      it "deletes the user" do
        expect {
          post users_deletions_path, params: params
        }.to change { User.count }.by(-1)
           .and change { UserDeleteReason.count }.by(1)
      end

      it "redirects to thank-you page with success message" do
        post users_deletions_path, params: params
        expect(response).to redirect_to(users_deletion_path("thank-you"))
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid user uuid" do
      let(:params) {
        {
          user: {
            uuid: "invalid-uuid",
            delete_reason_id: delete_reason.id
          }
        }
      }

      it "does not delete any user" do
        expect {
          post users_deletions_path, params: params
        }.not_to change { User.count }
      end

      it "renders the form with error message" do
        post users_deletions_path, params: params
        expect(response).to have_http_status(:ok)
        expect(flash[:alert]).to be_present
      end
    end

    context "when recaptcha fails" do
      before do
        allow(Rails.env).to receive(:development?).and_return(false)
        allow_any_instance_of(Users::DeletionsController).to receive(:verify_recaptcha).and_return(false)
      end

      let(:params) {
        {
          user: {
            uuid: user.uuid,
            delete_reason_id: delete_reason.id
          }
        }
      }

      it "does not delete the user" do
        expect {
          post users_deletions_path, params: params
        }.not_to change { User.count }
      end

      it "renders the form with error message" do
        post users_deletions_path, params: params
        expect(response).to have_http_status(:ok)
        expect(flash[:alert]).to be_present
      end
    end
  end
end
