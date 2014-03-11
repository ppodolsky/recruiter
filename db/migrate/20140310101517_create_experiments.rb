class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string :name
      t.text :description
      t.string :public_name
      t.string :context

      t.timestamps
    end
  end
end
