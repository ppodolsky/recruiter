class CreateCategoriesExperimentsJoinTable < ActiveRecord::Migration
  def change
    create_table :categories_experiments, id: false do |t|
      t.references :category, assigned: true
      t.references :experiment, assigned: true
    end
  end
end
