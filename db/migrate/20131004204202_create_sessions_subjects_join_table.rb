class CreateSessionsSubjectsJoinTable < ActiveRecord::Migration
  def change
    create_table :sessions_subjects, id: false do |t|
      t.integer :session_id
      t.integer :subject_id
      t.boolean :invited, :default => 0
      t.boolean :participated, :default => 0
    end
  end
end
