class AddCombinationToWish < ActiveRecord::Migration[5.1]
  def change
    add_column :wishes, :combination, :string
  end
end
