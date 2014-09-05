class AddColumnsToLegacyParticipation < ActiveRecord::Migration
  def change
    rename_column :legacy_participations, :legacy_user, :legacy_user_id
    add_column :legacy_participations, :session_id, :integer
    add_column :legacy_participations, :shown_up, :boolean
    add_column :legacy_participations, :participated, :boolean
    add_column :legacy_participations, :invited, :boolean
  end
end
