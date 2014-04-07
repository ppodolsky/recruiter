class AddDefaultInvitationColumn < ActiveRecord::Migration
  def change
    add_column :experiments, :default_invitation, :text
  end
end
