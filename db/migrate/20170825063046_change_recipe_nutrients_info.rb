class ChangeRecipeNutrientsInfo < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :recipe_nutrition_infos, :recipes

    add_foreign_key :recipe_nutrition_infos, :recipes, on_delete: :cascade
  end
end
