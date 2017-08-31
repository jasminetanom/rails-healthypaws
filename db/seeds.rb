require "faker"

Dose.delete_all
Recipe.delete_all
User.delete_all
Dog.delete_all

NUTRIENTS = %w(energy_kcal protein_g fat_g calcium_mg iron_mg magnesium_mg phosphorus_mg potassium_mg sodium_mg zinc_mg thiamin_mg riboflavin_mg niacin_mg pyridoxine_mg folate_ug vitamin_b12_ug vitamin_a_iu vitamin_e_mg vitamin_d_iu)

20.times do
  user = User.create(email: Faker::Internet.email, password: "123456", password_confirmation: "123456", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  p "User Created"

  dog = Dog.create({
    user: user,
    name: Faker::GameOfThrones.dragon,
    weight: rand(5..49),
    activity_level: ["low", "medium", "high"].sample,
    size: ["large", "medium", "small"].sample,
    is_sterilized: [true, true, false].sample,
    life_stage: ["adult", "senior", "puppy"].sample,
    body_condition_score: rand(1..5)
  })

  3.times do
    recipe = Recipe.create({
      name: Faker::Food.dish,
      dog: dog,
      photo: "http://res.cloudinary.com/tanjamiee/image/upload/v1504071220/HealthyPaws_Logo_Flavicon_flattened_ggoqcz.png"
    })

    3.times do
      recipe.doses << Dose.create({
        recipe: recipe,
        ingredient: Ingredient.all.sample,
        amount: rand(10..90),
        unit: ["mg", "ug"].sample
      })
    end

    recipe_nutrition_info = RecipeNutritionInfo.new(recipe_id: recipe.id)
    recipe.doses.each do |dose|
      NUTRIENTS.each do |nutrient|
        recipe_nutrition_info[nutrient] += (dose.ingredient[nutrient] * dose.amount)
      end
    end
    recipe_nutrition_info.save
  end
end
