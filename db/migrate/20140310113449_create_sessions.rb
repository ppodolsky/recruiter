class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.datetime :date_start
      t.datetime :date_finish
      t.datetime :session_length
      t.datetime :registration_start
      t.datetime :registration_finish
      t.belongs_to :experiment
      t.integer :required_subjects
      t.integer :lab

      t.timestamps
    end
  end
end
