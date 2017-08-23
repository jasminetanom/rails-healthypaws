class RemoveRiboflavinFromIngredients < ActiveRecord::Migration[5.1]
  def change
    remove_column :ingredients, :riboflavin_g, :float
  end
end
