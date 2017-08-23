class AddThiaminToNutritionReqs < ActiveRecord::Migration[5.1]
  def change
    add_column :nutrition_reqs, :thiamin_mg, :float
  end
end
