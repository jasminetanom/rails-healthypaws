class RemoveVitaminCFromIngredients < ActiveRecord::Migration[5.1]
  def change
    remove_column :ingredients, :vitamin_c_mg, :float
  end
end
