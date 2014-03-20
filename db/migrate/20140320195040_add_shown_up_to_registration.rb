class AddShownUpToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :shown_up, :boolean
  end
end
