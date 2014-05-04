class AddRewardToExperiment < ActiveRecord::Migration
  def change
    add_column :experiments, :reward, :decimal
  end
end
