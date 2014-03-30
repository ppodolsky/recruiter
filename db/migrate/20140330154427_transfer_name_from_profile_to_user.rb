class TransferNameFromProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, limit: 30
    add_column :users, :last_name, :string, limit: 30
    add_column :users, :gsharp, :string, limit: 9
    remove_column :profiles, :first_name, :string, limit: 30
    remove_column :profiles, :last_name, :string, limit: 30
    remove_column :profiles, :gsharp, :string, limit: 9

  end
end
