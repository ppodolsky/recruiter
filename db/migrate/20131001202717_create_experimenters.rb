class CreateExperimenters < ActiveRecord::Migration
  def change
# is it necessary to add creation of users table
    create_table :experimenters do |t|
      t.string :name
      t.belongs_to :user #foreign key (1-to-1 connection woth user)

      t.timestamps
    end
  end
end
