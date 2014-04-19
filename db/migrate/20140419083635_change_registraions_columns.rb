class ChangeRegistraionsColumns < ActiveRecord::Migration
  def change
    change_column :registrations, :shown_up, :boolean, :null => true, :default => nil
    change_column :registrations, :participated, :boolean, :null => true, :default => nil
  end
end
