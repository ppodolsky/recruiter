class RolifyCreateExperimenters < ActiveRecord::Migration
  def change
    create_table(:experimenters) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_experimenters, :id => false) do |t|
      t.references :user
      t.references :experimenter
    end

    add_index(:experimenters, :name)
    add_index(:experimenters, [ :name, :resource_type, :resource_id ])
    add_index(:users_experimenters, [ :user_id, :experimenter_id ])
  end
end
