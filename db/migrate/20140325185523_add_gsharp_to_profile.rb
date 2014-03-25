class AddGsharpToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :gsharp, :string, limit: 9
  end
end
