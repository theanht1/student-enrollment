class CreateUniversalPoint < ActiveRecord::Migration[5.1]
  def change
    create_table :universal_points do |t|
      t.integer :year
      t.string :combination
      t.integer :ranges, array: true

      t.timestamps
    end
  end
end
