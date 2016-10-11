class AddColumnsToUsers < ActiveRecord::Migration
  def change
      add_column :users, :email, :string
      add_column :users, :firstname, :string
      add_column :users, :lastname, :string
      add_column :users, :activated, :smallint

      add_index :users, :email
  end
end
