class CreateWish < ActiveRecord::Migration[5.1]
  def change
    create_table :wishes do |t|
      t.integer :user_id
      t.integer :university_id
    end

    add_foreign_key :wishes, :users
    add_foreign_key :wishes, :universities
  end
end
