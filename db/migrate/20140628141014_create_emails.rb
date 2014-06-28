class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails, :id => :string do |t|
      t.text :value

      t.timestamps
    end
  end
end
