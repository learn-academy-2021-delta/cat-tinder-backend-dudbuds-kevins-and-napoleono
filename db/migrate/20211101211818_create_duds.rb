class CreateDuds < ActiveRecord::Migration[6.1]
  def change
    create_table :duds do |t|
      t.string :name
      t.integer :age
      t.text :hobbies

      t.timestamps
    end
  end
end
