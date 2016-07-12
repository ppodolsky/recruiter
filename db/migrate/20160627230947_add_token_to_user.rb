class AddTokenToUser < ActiveRecord::Migration
#an extra migration for the app
  def change
    add_column :users, :token, :string
  end
end