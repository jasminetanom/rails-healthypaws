Ingredient.delete_all

ingredients = [
  {name:'Chicken breast, skinless, boneless',energy_kcal:1.51, protein_g:0.3054,fat_g:0.0317,fiber_g:0,calcium_mg:0.05,iron_mg:0.0045,magnesium_mg:0.34,phosphorus_mg:2.58,potassium_mg:3.91,sodium_mg:0.52,zinc_mg:0.009,niacin_mg:0.12133,pyridoxine_mg:0.01157,folate_ug:0,vitamin_b12_ug:0.0021,vitamin_a_iu:0.1,vitamin_e_mg:0.0054,vitamin_d_iu:0.01,riboflavin_mg:0.00213,thiamin_mg:0.00107},
  {name:'Cheese, Cheddar',energy_kcal:4.04,protein_g:0.2287,fat_g:0.3331,fiber_g:0,calcium_mg:7.1,iron_mg:0.0014,magnesium_mg:0.27,phosphorus_mg:4.55,potassium_mg:0.76,sodium_mg:6.53,zinc_mg:0.0364,niacin_mg:0.00059,pyridoxine_mg:0.00066,folate_ug:0.27,vitamin_b12_ug:0.011,vitamin_a_iu:12.42,vitamin_e_mg:0.0071,vitamin_d_iu:0.24,riboflavin_mg:0.00428,thiamin_mg:0.00029},
  {name:'Pacific Cod',energy_kcal:0.85,protein_g:0.1873,fat_g:0.005,fiber_g:0,calcium_mg:0.1,iron_mg:0.002,magnesium_mg:0.24,phosphorus_mg:3.45,potassium_mg:2.89,sodium_mg:3.72,zinc_mg:0.0039,niacin_mg:0.01343,pyridoxine_mg:0.00136,folate_ug:0.08,vitamin_b12_ug:0.0231,vitamin_a_iu:0.07,vitamin_e_mg:00067,vitamin_d_iu:0.24,riboflavin_mg:0.00055,thiamin_mg:0.00038},
  {name:'Brocolli',energy_kcal:0.35,protein_g:0.0238,fat_g:0.0041,fiber_g:0.033,calcium_mg:0.4,iron_mg:0.0067,magnesium_mg:0.21,phosphorus_mg:0.67,potassium_mg:2.93,sodium_mg:0.41,zinc_mg:0.0045,niacin_mg:0.00553,pyridoxine_mg:0.002,folate_ug:1.08,vitamin_b12_ug:0,vitamin_a_iu:15.48,vitamin_e_mg:0.0145,vitamin_d_iu:0,riboflavin_mg:0.00123,thiamin_mg:0.00063},
  {name:'Quinoa',energy_kcal:1.2,protein_g:0.044,fat_g:0.0192,fiber_g:0.028,calcium_mg:0.17,iron_mg:0.0149,magnesium_mg:0.64,phosphorus_mg:1.52,potassium_mg:1.72,sodium_mg:0.07,zinc_mg:0.0109,niacin_mg:0.00412,pyridoxine_mg:0.00123,folate_ug:0.42,vitamin_b12_ug:0,vitamin_a_iu:0.05,vitamin_e_mg:0.0063,vitamin_d_iu:0,riboflavin_mg:0.0011,thiamin_mg:0.00107}
]

ingredients.each do |ingredient|
  Ingredient.create(ingredient)
end


# Test data
judith = User.new(first_name: "Judith", last_name: "H", email: "judithyhh@gmail.com", password: "1234567", password_confirmation: "1234567")
jessica = User.new(first_name: "Jessica", last_name: "H", email: "hsiang.jessica@gmail.com", password: "1234567", password_confirmation: "1234567" )


lucky = Dog.new(name: "Lucky", weight: 6, activity_level: "low", size: "medium", is_sterilized: "true", life_stage: "adult", body_condition_score: "3", user_id: 1)
super_luck = Dog.new(name: "SuperLucky", weight: 5.8, activity_level: "low", size: "medium", is_sterilized: "false", life_stage: "adult", body_condition_score: "3", user_id: 2)


# Recipe 1
lucky_recipe_1 = Recipe.new(name: "Awesome beans", dog_id: 1)
# Recipe 3
lucky_recipe_2 = Recipe.new(name: "2nd Awesome beans", dog_id: 1)

# Recipe 2
super_lucky_recipe_1 = Recipe.new(name: "Awesome meal", dog_id: 2)
# Recipe 4
super_lucky_recipe_2 = Recipe.new(name: "2nd Awesome meal", dog_id: 2)

# Recipe 1
recipe_1_dose = Dose.new(recipe_id: 1, ingredient_id: 6, amount: 5)
recipe_1_dose_2 = Dose.new(recipe_id: 1, ingredient_id: 7, amount: 10)

# Recipe 2
recipe_2_dose_1 = Dose.new(recipe_id: 2, ingredient_id: 8, amount: 20)
recipe_2_dose_2 = Dose.new(recipe_id: 2, ingredient_id: 9, amount: 20)

# Recipe 3
recipe_3_dose_1 = Dose.new(recipe_id: 3, ingredient_id: 7, amount: 10)
recipe_3_dose_2 = Dose.new(recipe_id: 3, ingredient_id: 9, amount: 8)

# Recipe 4
recipe_4_dose_1 = Dose.new(recipe_id: 4, ingredient_id: 8, amount: 9)
recipe_4_dose_2 = Dose.new(recipe_id: 4, ingredient_id: 6, amount: 10)












