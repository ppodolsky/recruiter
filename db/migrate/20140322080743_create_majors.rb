class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors, {id: false, primary_key: :name}  do |t|
      t.string :name

      t.timestamps
    end
    remove_column :profiles, :major, :string
    add_column :profiles, :major, :string, references: :major
  end
end
