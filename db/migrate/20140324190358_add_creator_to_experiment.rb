class AddCreatorToExperiment < ActiveRecord::Migration
  def change
    add_column :experiments, :creator_id, :integer, references: :users
  end
end
