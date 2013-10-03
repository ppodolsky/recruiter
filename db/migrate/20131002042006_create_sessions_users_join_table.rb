class CreateSessionsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :sessions_users, id: false do |t|
      t.integer :session_id
      t.integer :user_id
      t.boolean :inveted, :default => 0
      t.boolean :participated, :default => 0
    end
  end
end
