class CreateCombination < ActiveRecord::Migration[5.1]
  def change
    create_table :combinations do |t|
      t.string :code
      t.integer :id1
      t.integer :id2
      t.integer :id3

      t.timestamps
    end
  end
end
