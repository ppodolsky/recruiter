class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :duration, null: false
      t.integer :registered_subjects
      t.integer :required_subjects
      t.references :lab, assigned: true
      t.boolean :finished, default: false, null: false
      t.datetime :registration_deadline, null: false

      t.timestamps
    end
  end
end
