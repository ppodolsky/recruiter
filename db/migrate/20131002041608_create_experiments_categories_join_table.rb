class CreateExperimentsCategoriesJoinTable < ActiveRecord::Migration
  def change
     create_table :experiments_categories, id: false do |t|
        t.integer :experiment_id
        t.integer :category_id
      end
  end
end
