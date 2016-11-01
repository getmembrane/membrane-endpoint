class ChangeAccuracyToDecimal < ActiveRecord::Migration
  def change
    remove_column :reports, :accuracy
    add_column :reports, :accuracy, :decimal, precision: 3, scale: 2
  end
end
