class AddIndexToAssignmentsAndRegistrations < ActiveRecord::Migration
  def change
    add_index :assignments, ["subject_id", "experiment_id"], :unique => true
    add_index :registrations, ["subject_id", "session_id"], :unique => true
  end
end
