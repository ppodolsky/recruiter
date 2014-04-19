class AddReferencesToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :experiment_id, :integer, null: false
    create_table :users_sessions, id: false do |t|
      t.references :user, assigned: true
      t.references :session, assigned: true
    end
  end
end
