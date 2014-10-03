class AddRemindAtToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :remind_at, :datetime
    add_column :sessions, :reminded, :boolean, default: false
  end
end
