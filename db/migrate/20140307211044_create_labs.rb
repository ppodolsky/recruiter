class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :location, limit: 255, null: false

      t.timestamps
    end

    add_index :labs, :location, unique: true
  end
end
