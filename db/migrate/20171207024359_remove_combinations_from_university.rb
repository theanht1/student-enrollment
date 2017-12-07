class RemoveCombinationsFromUniversity < ActiveRecord::Migration[5.1]
  def change
    remove_column :universities, :combinations
  end
end
