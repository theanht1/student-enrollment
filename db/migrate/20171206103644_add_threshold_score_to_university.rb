class AddThresholdScoreToUniversity < ActiveRecord::Migration[5.1]
  def change
    add_column :universities, :threshold_score, :float
  end
end
