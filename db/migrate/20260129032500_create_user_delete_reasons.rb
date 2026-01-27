# frozen_string_literal: true

class CreateUserDeleteReasons < ActiveRecord::Migration[6.1]
  def change
    create_table :user_delete_reasons do |t|
      t.bigint :user_id
      t.uuid :delete_reason_id

      t.timestamps
    end

    add_index :user_delete_reasons, :user_id
    add_index :user_delete_reasons, :delete_reason_id
  end
end
