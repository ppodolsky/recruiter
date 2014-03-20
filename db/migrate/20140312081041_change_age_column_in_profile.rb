class ChangeAgeColumnInProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :age
    add_column :profiles, :birth_year, :integer
  end
end
