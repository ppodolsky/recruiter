class AddPaidToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :paid, :decimal
  end
end
