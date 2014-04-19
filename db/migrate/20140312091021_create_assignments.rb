class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments, id: false do |t|
      t.references :subject, assigned: true
      t.references :experiment, assigned: true
    end
  end
end
