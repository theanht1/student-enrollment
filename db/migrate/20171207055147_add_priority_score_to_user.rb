class AddPriorityScoreToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :priority_score, :float, default: 0
  end
end
