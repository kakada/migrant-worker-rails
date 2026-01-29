# frozen_string_literal: true

module Api
  module V2
    class UsersController < ApiController
      def create
        params[:user] = JSON.parse(params[:user])
        user = User.find_or_initialize_by(uuid: user_params[:uuid])
        if user.update(user_params)
          render json: user, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find_by!(uuid: params[:id])

        if user.destroy_with_reason(params[:delete_reason_id])
          render json: { message: "User deleted successfully" }, status: :ok
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private
        def user_params
          param = params.require(:user).permit(:uuid, :full_name, :sex, :age, :registered_at)
          param = param.merge(audio: params[:audio]) if params[:audio].present?
          param
        end
    end
  end
end
