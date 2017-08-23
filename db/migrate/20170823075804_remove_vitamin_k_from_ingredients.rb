class RemoveVitaminKFromIngredients < ActiveRecord::Migration[5.1]
  def change
    remove_column :ingredients, :vitamin_k_ug, :float
  end
end
