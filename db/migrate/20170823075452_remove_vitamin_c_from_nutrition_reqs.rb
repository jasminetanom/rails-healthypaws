class RemoveVitaminCFromNutritionReqs < ActiveRecord::Migration[5.1]
  def change
    remove_column :nutrition_reqs, :vitamin_c_mg, :float
  end
end
