class CreateCategoriesExperimentsJoinTable < ActiveRecord::Migration
  def change
    create_table :categories_experiments, id: false do |t|
      t.references :category, index: true
      t.references :experiment, index: true
    end
  end
end
