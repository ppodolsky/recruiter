class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations, id: false do |t|
      t.references :subject, index: true
      t.references :session, index: true
      t.boolean :participated
    end
  end
end
