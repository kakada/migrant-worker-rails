# frozen_string_literal: true

module Users
  module ScheduleDeletionConcern
    extend ActiveSupport::Concern

    included do
      acts_as_paranoid

      REMOVING_INTERVAL = ENV.fetch("REMOVING_INTERVAL") { 30 }.to_i # days

      # Associations
      has_many :user_delete_reasons, foreign_key: :user_id

      # Callbacks
      after_destroy :schedule_real_destroy
      after_real_destroy :remove_association

      def destroy_with_reason(delete_reason_id = nil)
        if delete_reason_id.blank?
          errors.add(:reason, "cannot be blank")
          return false
        end

        User.transaction do
          user_delete_reasons.create!(delete_reason_id: delete_reason_id)
          destroy
        end
      rescue ActiveRecord::RecordInvalid
        false
      end

      private
        def removing_date
          @removing_date ||= deleted_at + REMOVING_INTERVAL.days
        end

        def schedule_real_destroy
          UserDeletionJob.set(wait_until: removing_date).perform_later(id)
        end

        def remove_association
          surveys.delete_all
        end
    end
  end
end
