class RemoveBodyConditioningScoreFromDogs < ActiveRecord::Migration[5.1]
  def change
    remove_column :dogs, :body_conditioning_score, :integer
  end
end
