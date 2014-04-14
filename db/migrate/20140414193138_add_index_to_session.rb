class AddIndexToSession < ActiveRecord::Migration
  def change
    add_index "sessions", ["experiment_id"], name: "index_sessions_on_experiment_id", using: :btree
  end
end
