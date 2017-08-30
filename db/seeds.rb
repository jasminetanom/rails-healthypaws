require "faker"

Dose.delete_all
Recipe.delete_all
User.delete_all
Dog.delete_all


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
        amount: rand(1..9),
        unit: ["mg", "ug"].sample
      })
    end
  end
end
