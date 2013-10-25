class CreateCategoriesExperimentsJoinTable < ActiveRecord::Migration
    def change
       create_table :categories_experiments, id: false do |t|
          t.integer :experiment_id
          t.integer :category_id
        end
    end
  end
  
