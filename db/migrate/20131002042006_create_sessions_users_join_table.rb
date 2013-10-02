class CreateSessionsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :experiments_experimenters, id: false do |t|
      t.integer :session_id
      t.integer :user_id
  end
end
