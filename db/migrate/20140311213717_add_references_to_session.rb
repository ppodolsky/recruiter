class AddReferencesToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :experiment_id, :integer, null: false
    create_table :users_sessions, id: false do |t|
      t.references :user, index: true
      t.references :session, index: true
    end
  end
end
