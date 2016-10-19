class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :client_id
      t.string :profile_id
      t.string :source
      t.string :content

      t.timestamps null: false
    end
  end
end
