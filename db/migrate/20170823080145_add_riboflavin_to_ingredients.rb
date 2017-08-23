class AddRiboflavinToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients, :riboflavin_mg, :float
  end
end
