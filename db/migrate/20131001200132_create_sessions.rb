class CreateSessions < ActiveRecord::Migration
  def change

    
    create_table :experiments do |t|
      t.string :name
      t.text :decription
      t.bool :active :default => 1

      t.timestamps
    end
    
    
    create_table :sessions do |t|
      t.belongs_to :experiment
      t.datetime :date_start
      t.datetime :date_stop

      t.timestamps
    end
  end
end
