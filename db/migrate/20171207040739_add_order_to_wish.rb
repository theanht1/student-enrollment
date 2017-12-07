class AddOrderToWish < ActiveRecord::Migration[5.1]
  def change
    add_column :wishes, :order, :integer
  end
end
