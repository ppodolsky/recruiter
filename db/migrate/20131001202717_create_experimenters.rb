class CreateExperimenters < ActiveRecord::Migration
  def change
    create_table :experimenters do |t|
      t.string :name

      t.timestamps
    end
  end
end
