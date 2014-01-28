class AddMajorToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :major, :string, null: false, limit: 30
  end
end
