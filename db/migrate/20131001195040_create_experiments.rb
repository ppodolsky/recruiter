class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string :name
      t.text :decription, :default => ""
      t.boolean :active, :default => 1

      t.timestamps
    end
  end
end
