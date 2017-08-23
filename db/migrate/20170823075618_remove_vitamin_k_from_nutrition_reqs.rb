class RemoveVitaminKFromNutritionReqs < ActiveRecord::Migration[5.1]
  def change
    remove_column :nutrition_reqs, :vitamin_k_ug, :float
  end
end
