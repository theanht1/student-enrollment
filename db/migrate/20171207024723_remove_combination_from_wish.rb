class RemoveCombinationFromWish < ActiveRecord::Migration[5.1]
  def change
    remove_column :wishes, :combination
  end
end
