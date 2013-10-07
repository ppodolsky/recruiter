class CreateExperimentsExperimentersJoinTable < ActiveRecord::Migration
  def change
    create_table :experiments_experimenters, id: false do |t|
      t.integer :experiment_id
      t.integer :experimenter_id
    end
  end
end