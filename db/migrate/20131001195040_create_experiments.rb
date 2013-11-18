class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string :name, null: false
      t.text :decription, default: ""
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
