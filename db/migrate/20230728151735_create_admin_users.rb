# frozen_string_literal: true

class CreateAdminUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_users do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.string :api_key, unique: true, null: false
      t.boolean :is_super, default: false

      t.timestamps
    end
  end
end
