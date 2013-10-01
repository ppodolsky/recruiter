class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string :name
      t.text :decription
      t.bool :active :default => 1

      t.timestamps
    end
  end
end
