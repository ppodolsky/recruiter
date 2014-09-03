class CreateLegacyUsers < ActiveRecord::Migration
  def change
    create_table :legacy_users do |t|
      t.string :email

      t.timestamps
    end
  end
end
