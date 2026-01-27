# frozen_string_literal: true

module Api
  module V2
    class DeleteReasonsController < ApiController
      def index
        pagy, delete_reasons = pagy(DeleteReason.order(:display_order))

        render json: {
          meta: {
            pagination: {
              page: pagy.page,
              items: pagy.items,
              count: pagy.count,
              pages: pagy.pages
            }
          },
          data: ActiveModelSerializers::SerializableResource.new(
            delete_reasons,
            each_serializer: DeleteReasonSerializer
          ).as_json
        }
      end
    end
  end
end
