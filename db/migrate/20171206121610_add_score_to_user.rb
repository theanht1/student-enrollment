class AddScoreToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :scores, :jsonb, array: true, default: []
  end
end
