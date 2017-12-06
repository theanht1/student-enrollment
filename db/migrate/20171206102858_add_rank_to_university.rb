class AddRankToUniversity < ActiveRecord::Migration[5.1]
  def change
    add_column :universities, :rank, :integer
  end
end
