class CreateUniversity < ActiveRecord::Migration[5.1]
  def change
    create_table :universities do |t|
      t.string :code
      t.string :name
      t.string :branch
      t.string :combinations, array: true
      t.integer :amount_2016
      t.float :score_2016
      t.integer :amount_2017

      t.timestamps
    end
  end
end
