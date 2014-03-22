class CreateEthnicities < ActiveRecord::Migration
  def change
    create_table :ethnicities, {id: false, primary_key: :name}  do |t|
      t.string :name

      t.timestamps
    end
    remove_column :profiles, :ethnicity, :string
    add_column :profiles, :ethnicity, :string, references: :ethnicity
  end
end
