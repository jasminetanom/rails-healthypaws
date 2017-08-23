class RemoveThiaminFromNutritionReqs < ActiveRecord::Migration[5.1]
  def change
    remove_column :nutrition_reqs, :thiamin_g, :float
  end
end
