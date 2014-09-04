class AddIsReservationToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :reservation, :boolean, :null => false, :default => false
  end
end
