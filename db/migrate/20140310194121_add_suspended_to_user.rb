class AddSuspendedToUser < ActiveRecord::Migration
  def change
    add_column :users, :suspended, :boolean, default: false, null: false
  end
end
