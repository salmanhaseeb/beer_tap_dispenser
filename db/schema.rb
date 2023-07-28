# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_728_151_735) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'admin_users', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.string 'api_key', null: false
    t.boolean 'is_super', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'dispensers', force: :cascade do |t|
    t.float 'flow_volume'
    t.float 'price_per_liter'
    t.float 'total_capacity'
    t.float 'remaining_volume'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'events', force: :cascade do |t|
    t.string 'event_type'
    t.datetime 'event_time'
    t.float 'total_spend'
    t.bigint 'dispenser_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.float 'total_drink_poured'
    t.index ['dispenser_id'], name: 'index_events_on_dispenser_id'
  end

  add_foreign_key 'events', 'dispensers'
end
