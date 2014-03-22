class CreateClassYears < ActiveRecord::Migration
  def change
    create_table :class_years, {id: false, primary_key: :year}do |t|
      t.integer :year
      t.string :name
      t.timestamps
    end
    remove_column :profiles, :class_year, :string
    add_column :profiles, :class_year, :integer, references: :class_year
  end
end
