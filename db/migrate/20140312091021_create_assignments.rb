class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments, id: false do |t|
      t.references :subject, index: true
      t.references :experiment, index: true
    end
  end
end
