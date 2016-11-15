class CreteApiKeys < ActiveRecord::Migration
  def change
      create_table "api_keys", force: :cascade do |t|
          t.string   "name",       null: false
          t.string   "key",        null: false
          t.datetime "created_at", null: false
          t.datetime "updated_at", null: false
      end

      add_index "api_keys", ["key"], name: "index_api_keys_on_key", unique: true, using: :btree

      add_column :users, :api_key_id, :integer
  end
end
