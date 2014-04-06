class RenameSubjectIdToUserId < ActiveRecord::Migration
  def change
    rename_column :registrations, :subject_id, :user_id
    rename_column :assignments, :subject_id, :user_id
  end
end
