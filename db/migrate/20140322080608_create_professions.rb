class CreateProfessions < ActiveRecord::Migration
  def change
    create_table :professions, {id: false, primary_key: :name} do |t|
      t.string :name
      t.timestamps
    end
    remove_column :profiles, :profession, :string
    add_column :profiles, :profession, :string, references: :profession
  end
end
