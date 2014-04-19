class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations, id: false do |t|
      t.references :subject, assigned: true
      t.references :session, assigned: true
      t.boolean :participated
    end
  end
end
