class ChangeDefaultInRegistration < ActiveRecord::Migration
  def change
    change_column :registrations, :participated, :boolean, :default => false
    change_column :registrations, :shown_up, :boolean, :default => false
  end
end
