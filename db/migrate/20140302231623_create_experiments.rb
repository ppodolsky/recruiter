class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string :name, limit: 255, null: false
      t.string :description, limit: 255
      t.string :type, limit: 255
      t.boolean :finished, default: false, null: false

      t.timestamps
    end

    add_index :experiments, :name, unique: true
  end
end
