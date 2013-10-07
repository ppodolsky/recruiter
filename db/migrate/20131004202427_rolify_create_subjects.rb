class RolifyCreateSubjects < ActiveRecord::Migration
  def change
    create_table(:subjects) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:users_subjects, :id => false) do |t|
      t.references :user
      t.references :subject
    end

    add_index(:subjects, :name)
    add_index(:subjects, [ :name, :resource_type, :resource_id ])
    add_index(:users_subjects, [ :user_id, :subject_id ])
  end
end
