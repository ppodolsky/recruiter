class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, assigned: true
      t.string :secondary_email
      t.string :first_name, limit: 30
      t.string :last_name, limit: 30
      t.string :phone, limit: 14
      t.string :gender, limit: 1
      t.string :ethnicity, limit: 8
      t.integer :age, limit: 2
      t.string :class_year
      t.integer :total_years, limit: 2
      t.integer :year_started
      t.decimal :current_gpa, precision: 3, scale: 2
      t.integer :years_resident, limit: 2
      t.string :profession

      t.timestamps
    end
    add_index :profiles, :secondary_email, unique: true
  end
end
