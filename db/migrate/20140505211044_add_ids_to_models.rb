class AddIdsToModels < ActiveRecord::Migration
  def change
    add_column :ethnicities, :id, :primary_key
    add_column :majors, :id, :primary_key
    add_column :professions, :id, :primary_key
  end
end
