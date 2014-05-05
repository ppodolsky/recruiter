class AddDefaultValueToExperiment < ActiveRecord::Migration
  def change
    change_column :experiments, :reward, :decimal, :null => true, :default => 5
  end
end
