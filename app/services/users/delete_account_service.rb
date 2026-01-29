# frozen_string_literal: true

module Users
  class DeleteAccountService
    Result = Struct.new(:success?, :user, keyword_init: true)

    def self.call(uuid:, delete_reason_id:)
      new(uuid, delete_reason_id).call
    end

    def initialize(uuid, delete_reason_id)
      @uuid = uuid
      @delete_reason_id = delete_reason_id
    end

    def call
      user = User.find_by(uuid: @uuid) || User.new

      unless user.persisted?
        user.errors.add(:uuid, :not_found, message: I18n.t("users.deletions.user_not_found"))
        return Result.new(success?: false, user: user)
      end

      unless user.destroy_with_reason(@delete_reason_id)
        user.errors.add(:base, :deletion_failed, message: I18n.t("users.deletions.failed"))
        return Result.new(success?: false, user: user)
      end

      Result.new(success?: true, user: user)
    end
  end
end
