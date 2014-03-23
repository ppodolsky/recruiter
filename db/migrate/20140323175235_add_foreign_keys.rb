class AddForeignKeys < ActiveRecord::Migration
  def change
    add_index :majors, :name, unique: true
    add_index :professions, :name, unique: true
    add_index :ethnicities, :name, unique: true
    add_index :class_years, :year, unique: true
    add_foreign_key(:profiles, :majors, :column => 'major', :primary_key => 'name')
    add_foreign_key(:profiles, :professions, :column => 'profession', :primary_key => 'name')
    add_foreign_key(:profiles, :ethnicities, :column => 'ethnicity', :primary_key => 'name')
    add_foreign_key(:profiles, :class_years, :column => 'class_year', :primary_key => 'year')
  end
end
