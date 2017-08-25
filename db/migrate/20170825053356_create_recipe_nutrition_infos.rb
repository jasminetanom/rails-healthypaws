class CreateRecipeNutritionInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_nutrition_infos do |t|
      t.references :recipe, foreign_key: true
      t.float :energy_kcal, default: 0
      t.float :protein_g, default: 0
      t.float :fat_g, default: 0
      t.float :fiber_g, default: 0
      t.float :calcium_mg, default: 0
      t.float :iron_mg, default: 0
      t.float :magnesium_mg, default: 0
      t.float :phosphorus_mg, default: 0
      t.float :potassium_mg, default: 0
      t.float :sodium_mg, default: 0
      t.float :zinc_mg, default: 0
      t.float :thiamin_mg, default: 0
      t.float :riboflavin_mg, default: 0
      t.float :niacin_mg, default: 0
      t.float :pyridoxine_mg, default: 0
      t.float :folate_ug, default: 0
      t.float :vitamin_b12_ug, default: 0
      t.float :vitamin_a_iu, default: 0
      t.float :vitamin_e_mg, default: 0
      t.float :vitamin_d_iu, default: 0
      t.timestamps
    end
  end
end
