class AddAccuracyToReports < ActiveRecord::Migration
  def change
      add_column :reports, :accuracy, :string
  end
end
