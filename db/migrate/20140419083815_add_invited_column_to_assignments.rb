class AddInvitedColumnToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :invited, :boolean, :default => false
  end
end
