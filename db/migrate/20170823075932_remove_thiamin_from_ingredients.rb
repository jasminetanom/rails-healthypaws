class RemoveThiaminFromIngredients < ActiveRecord::Migration[5.1]
  def change
    remove_column :ingredients, :thiamin_g, :float
  end
end
