# frozen_string_literal: true

class CreateDeleteReasons < ActiveRecord::Migration[6.1]
  def change
    create_table :delete_reasons, id: :uuid do |t|
      t.string :name_km
      t.string :name_en
      t.integer :display_order
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :delete_reasons, :deleted_at
    add_index :delete_reasons, :display_order
  end
end
