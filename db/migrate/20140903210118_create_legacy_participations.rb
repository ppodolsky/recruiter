class CreateLegacyParticipations < ActiveRecord::Migration
  def change
    create_table :legacy_participations do |t|
      t.integer :experiment
      t.integer :legacy_user

      t.timestamps
    end
  end
end
