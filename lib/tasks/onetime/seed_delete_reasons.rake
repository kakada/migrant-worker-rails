# frozen_string_literal: true

require "samples/delete_reason"

namespace :onetime do
  desc "Seed delete reasons data"
  task seed_delete_reasons: :environment do
    puts "Seeding delete reasons..."
    Samples::DeleteReason.load
    puts "Delete reasons seeded successfully!"
  end
end
