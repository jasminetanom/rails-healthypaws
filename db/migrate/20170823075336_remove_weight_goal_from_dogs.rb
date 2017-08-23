class RemoveWeightGoalFromDogs < ActiveRecord::Migration[5.1]
  def change
    remove_column :dogs, :weight_goal, :string
  end
end
