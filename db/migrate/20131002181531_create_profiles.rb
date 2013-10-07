class CreateProfiles < ActiveRecord::Migration
  def change
     create_table :profiles do |t|
       t.belongs_to :user, index: true
       t.string :secondary_email
       t.string :first_name, limit: 30
       t.string :last_name, limit: 30
       t.string :phone, limit: 14
       t.string :gender, limit: 1
       t.string :ethnicity, limit: 8
       t.integer :age, limit: 1
       t.date :class_year
       t.integer :total_years, limit: 1
       t.date :year_started
       t.decimal :current_gpa, precision: 3, scope: 2
       t.integer :years_resident, limit: 1
       t.string :profession

       t.timestamps
     end
     add_index :profiles, :secondary_email, unique: true
   end
end
