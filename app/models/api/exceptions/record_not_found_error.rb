# frozen_string_literal: true

module Api
  module Exceptions
    class RecordNotFoundError < Error
      def initialize(message, params)
        @message = message
        @params = params
        @status = 404
      end

      def errors
        [
          Api::Error.new(
            code: 404,
            status: :not_found,
            title: "Record Not Found",
            detail: "The record identified by #{id} could not be found."
          )
        ]
      end

      private
        def id
          # 1️⃣ Try to extract the ID from the exception message (standard ActiveRecord format)
          @message.match(/=(\S+)/)&.[](1)

          # 2️⃣ Fallback: use the last value from params (e.g., :user_id in nested routes)
          @params&.values&.last || "unknown"
        end
    end
  end
end
