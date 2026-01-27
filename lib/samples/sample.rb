# frozen_string_literal: true

Dir["/app/lib/builders/*.rb"].each { |file| require file }
Dir["/app/lib/exporters/*.rb"].each { |file| require file }

require_relative "account"
require_relative "need_for_help"
require_relative "user"
require_relative "category"
require_relative "form"
require_relative "delete_reason"
require_relative "visit"
require_relative "survey"

module Samples
  class Sample
    def self.load
      ::Samples::Account.load
      ::Samples::NeedForHelp.load
      ::Samples::User.load
      ::Samples::Category.load
      ::Samples::Form.load
      ::Samples::DeleteReason.load
    end

    def self.export
      ::Samples::Category.export
      ::Samples::Form.export
      ::Samples::NeedForHelp.export
    end
  end
end
