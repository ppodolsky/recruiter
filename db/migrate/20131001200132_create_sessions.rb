class CreateSessions < ActiveRecord::Migration
  def change
   
    create_table :sessions do |t|
      t.belongs_to :experiment #foreign key (belongs_to :experimenter) 
      t.datetime :date_start
      t.datetime :date_stop

      t.timestamps
    end
  end
end
