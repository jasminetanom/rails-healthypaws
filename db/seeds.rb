require "faker"

Dose.delete_all
Recipe.delete_all
User.delete_all
Dog.delete_all

NUTRIENTS = %w(energy_kcal protein_g fat_g calcium_mg iron_mg magnesium_mg phosphorus_mg potassium_mg sodium_mg zinc_mg thiamin_mg riboflavin_mg niacin_mg pyridoxine_mg folate_ug vitamin_b12_ug vitamin_a_iu vitamin_e_mg vitamin_d_iu)

human_url = ["http://lorempixel.com/250/250/people/1","http://lorempixel.com/250/250/people/2","http://lorempixel.com/250/250/people/3","http://lorempixel.com/250/250/people/4","http://lorempixel.com/250/250/people/5","http://lorempixel.com/250/250/people/6","http://lorempixel.com/250/250/people/7","http://lorempixel.com/250/250/people/8","http://lorempixel.com/250/250/people/9","http://lorempixel.com/250/250/people/10"]

  dog_url = ["http://res.cloudinary.com/tanjamiee/image/upload/v1504236105/IMG_2552_llmmbl.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236127/D1_c5nnvf.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236126/D2_xzooi5.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236126/D3_qltn8q.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236127/D12_l4mqce.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236126/D4_i3ktnl.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236126/D6_fmyfsu.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236126/D5_iuqq6p.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236127/D11_zh1vfj.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236127/D13_velkao.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236128/D10_pynzce.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236127/D8_jtg9f4.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236128/D14_kqtof7.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236129/D16_uq2fjw.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236127/D9_nepeod.jpg"]

  recipe_url = ["http://res.cloudinary.com/tanjamiee/image/upload/v1504236443/DF1_jmywhe.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236446/DF10_mxlibk.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236445/DF11_sfoatk.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236445/DF12_eom9n9.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236447/DF13_qwofzc.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236446/DF14_oo1ysv.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236446/DF15_ysoodr.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236446/DF16_dwxleg.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236447/DF17_l42wi0.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236447/DF18_tcpgyn.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236448/DF19_meapzb.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236443/DF2_xvqwow.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236447/DF20_bfftrd.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236447/DF21_gasjnv.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236448/DF22_mnlt47.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236449/DF23_zkkbxj.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236449/DF24_past1o.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236450/DF25_k2eg5b.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236443/DF3_nmkxun.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236444/DF4_zfckat.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236444/DF5_qupgbx.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236445/DF6_sjijnw.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236445/DF7_r2pgiq.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236445/DF8_kegery.jpg","http://res.cloudinary.com/tanjamiee/image/upload/v1504236444/DF9_kv4sel.jpg"]

20.times do
  user = User.create(email: Faker::Internet.email, password: "123456", password_confirmation: "123456", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, remote_photo_url: human_url.sample)
  p "User Created"

  dog = Dog.create!({
    user: user,
    name: Faker::Cat.name,
    weight: rand(5..49),
    activity_level: ["low", "medium", "high"].sample,
    size: ["large", "medium", "small"].sample,
    is_sterilized: [true, true, false].sample,
    life_stage: ["adult", "senior", "puppy"].sample,
    body_condition_score: [3, rand(1..5)].sample,
    remote_photo_url: dog_url.sample
  })

  2.times do
    recipe = Recipe.create({
      name: Faker::Food.dish,
      dog: dog,
      remote_photo_url: recipe_url.sample
    })

    3.times do
      recipe.doses << Dose.create({
        recipe: recipe,
        ingredient: Ingredient.all.sample,
        amount: rand(10..900),
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
