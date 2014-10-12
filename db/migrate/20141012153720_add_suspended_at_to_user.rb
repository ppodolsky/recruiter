class AddSuspendedAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :suspended_at, :datetime, default: DateTime.new(2014, 9, 1)
  end
end
