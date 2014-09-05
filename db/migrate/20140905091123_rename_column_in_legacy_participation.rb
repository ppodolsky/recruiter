class RenameColumnInLegacyParticipation < ActiveRecord::Migration
  def change
    rename_column :legacy_participations, :experiment, :experiment_id
  end
end
