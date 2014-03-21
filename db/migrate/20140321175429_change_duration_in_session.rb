class ChangeDurationInSession < ActiveRecord::Migration
  def change
    remove_column :sessions, :duration
    add_column :sessions, :duration, :time
  end
end
