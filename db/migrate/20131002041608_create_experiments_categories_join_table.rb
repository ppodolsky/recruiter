class CreateExperimentsCategoriesJoinTable < ActiveRecord::Migration
  def change
     create_table :experiments_experimenters, id: false do |t|
        t.integer :experiment_id
        t.integer :category_id
  end
end
