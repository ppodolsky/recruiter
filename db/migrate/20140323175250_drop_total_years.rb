class DropTotalYears < ActiveRecord::Migration
  def change
    remove_column :profiles, :total_years, :integer
  end
end
