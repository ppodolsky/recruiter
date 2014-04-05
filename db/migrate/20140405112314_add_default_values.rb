class AddDefaultValues < ActiveRecord::Migration
  def change
    change_column :users, :type, :string, :default => 'Subject'
    change_column :registrations, :shown_up, :boolean, :default => false
    change_column :registrations, :participated, :boolean, :default => false
  end
end
