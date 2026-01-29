# frozen_string_literal: true

require "csv"

module Samples
  class DeleteReason
    def self.load
      csv_file = File.read(Rails.root.join("lib", "samples", "assets", "delete_reasons.csv"))
      csv = CSV.parse(csv_file, headers: true)

      csv.each do |row|
        ::DeleteReason.create!(
          name_km: row["name_km"],
          name_en: row["name_en"],
          display_order: row["display_order"].to_i
        )
      end
    end
  end
end
