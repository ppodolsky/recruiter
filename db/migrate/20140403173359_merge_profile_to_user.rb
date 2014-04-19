class MergeProfileToUser < ActiveRecord::Migration
  def self.up
      add_column :users, :secondary_email, :string
      add_column :users, :phone, :string, limit: 14
      add_column :users, :gender, :string, limit: 1
      add_column :users, :ethnicity, :string
      add_column :users, :birth_year, :integer
      add_column :users, :class_year, :integer, references: :class_year
      add_column :users, :year_started, :integer
      add_column :users, :current_gpa, :decimal, precision: 3, scale: 2
      add_column :users, :years_resident, :integer, limit: 2
      add_column :users, :profession, :string
      add_column :users, :major, :string, limit: 30
      add_index :users, :secondary_email, unique: true
      execute "UPDATE users SET secondary_email = p.secondary_email,
      phone = p.phone, gender = p.gender, ethnicity = p.ethnicity,
      birth_year = p.birth_year, class_year = p.class_year, year_started = p.year_started,
      current_gpa = p.current_gpa, years_resident = p.years_resident, profession = p.profession FROM
      profiles p
      WHERE users.id = p.user_id"
      drop_table :profiles
  end

  def self.down
    create_table :profiles do |t|
      t.references :user, assigned: true
      t.string :secondary_email
      t.string :major, limit: 30
      t.string :phone, limit: 14
      t.string :gender, limit: 1
      t.string :ethnicity
      t.integer :birth_year
      t.integer :year_started
      t.decimal :current_gpa, precision: 3, scale: 2
      t.integer :years_resident
      t.string :profession

      t.timestamps
    end
    add_column :profiles, :class_year, :integer, references: :class_year
    add_index :profiles, :secondary_email, unique: true
    execute "UPDATE profiles SET secondary_email = u.secondary_email,
      phone = u.phone, gender = u.gender, ethnicity = u.ethnicity,
      birth_year = u.birth_year, class_year = u.class_year, year_started = u.year_started,
      current_gpa = u.current_gpa, years_resident = u.years_resident, profession = u.profession FROM
      users u
      WHERE u.id = user_id"
    remove_index :users, :secondary_email
    remove_column :users, :secondary_email, :string
    remove_column :users, :phone, :string, limit: 14
    remove_column :users, :gender, :string, limit: 1
    remove_column :users, :ethnicity, :string
    remove_column :users, :birth_year, :integer
    remove_column :users, :class_year, :integer, references: :class_year
    remove_column :users, :year_started, :integer
    remove_column :users, :current_gpa, :decimal, precision: 3, scale: 2
    remove_column :users, :years_resident, :integer, limit: 2
    remove_column :users, :profession, :string
    remove_column :users, :major, :string
  end
end
