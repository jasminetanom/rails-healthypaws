class DogsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @user = current_or_guest_user
    @dog = Dog.new(user: @user)
  end

  def create
    @dog = Dog.new(dog_params)
      unless @dog.save
        render :new
      end
    @dog.multiplier = get_multiplier(dog_params)
    @dog.save
    reqs = get_reqs(dog_params[:weight].to_f, @dog.multiplier, @dog.life_stage)
    @nutrition_req = NutritionReq.new(dog: @dog)
    reqs.each do |nutrient, amount|
      @nutrition_req[nutrient] = amount
    end
    if @nutrition_req.save
      redirect_to new_recipe_path
    else
      format.html { render :new }
      format.json { render json: @dog.errors, status: :unprocessable_entity }
    end
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def update
    @dog = Dog.find(params[:id])
    if @dog.update(dog_params)
      redirect_to dashboard_path
    else
      render :update
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    @dog.destroy
  end

  private

  def dog_params
    params.require(:dog).permit(:user_id, :name, :photo, :photo_cache, :weight, :activity_level, :size, :is_sterilized, :life_stage, :body_condition_score)
  end

  def get_multiplier(dog_params)
    multipliers = { "activity_level" => { "low" => 1.06, "medium" => 1.14, "high" => 1.31 }, "size" => { "large" => 1.00, "medium" => 1.13, "small" => 1.29 }, "is_sterilized" => { "true" => 1.16, "false" => 1.37 }, "life_stage" => { "adult" => 1.00, "senior" => 0.81, "puppy" => 2.45 }, "body_condition_score" => { "1" => 1.43, "2" => 1.18, "3" => 1.00, "4" => 0.87, "5" => 0.77} }
    a_l_m = multipliers["activity_level"][dog_params["activity_level"]].to_f
    s_m = multipliers["size"][dog_params["size"]].to_f
    i_s_m = multipliers["is_sterilized"][dog_params["is_sterilized"]].to_f
    l_s_m = multipliers["life_stage"][dog_params["life_stage"]].to_f
    b_c_s_m = multipliers["body_condition_score"][dog_params["body_condition_score"]].to_f
    total_multiplier = a_l_m * s_m * i_s_m * l_s_m * b_c_s_m
    return total_multiplier
  end

  def get_reqs(weight, multiplier, life_stage)
    resting_energy_req = 70 * ((weight.to_f) ** 0.75)
    daily_energy_req = resting_energy_req * multiplier
    coeff = daily_energy_req / 1000
    if life_stage == "puppy"
      req = {
      energy_kcal: daily_energy_req,
      protein_g: coeff * 56.3,
      fat_g: coeff * 21.3,
      fiber_g: 0,
      calcium_mg: coeff * 3000,
      iron_mg: coeff * 22,
      magnesium_mg: coeff * 100,
      phosphorus_mg: coeff * 2500,
      potassium_mg: coeff * 1500,
      sodium_mg: coeff * 800,
      zinc_mg: coeff * 25,
      thiamin_mg: coeff * 0.56,
      riboflavin_mg: coeff * 1.3,
      niacin_mg: coeff * 3.4,
      pyridoxine_mg: coeff * 0.38,
      folate_ug: coeff * 54,
      vitamin_b12_ug: coeff * 7,
      vitamin_a_iu: coeff * 1250,
      vitamin_e_mg: coeff * 0.8 * 12.5,
      vitamin_d_iu: coeff * 125
      }
    else
      req = {
      energy_kcal: daily_energy_req,
      protein_g: coeff * 45.0,
      fat_g: coeff * 13.8,
      fiber_g: 0,
      calcium_mg: coeff * 1250,
      iron_mg: coeff * 10,
      magnesium_mg: coeff * 150,
      phosphorus_mg: coeff * 1000,
      potassium_mg: coeff * 1500,
      sodium_mg: coeff * 200,
      zinc_mg: coeff * 20,
      thiamin_mg: coeff * 0.56,
      riboflavin_mg: coeff * 1.3,
      niacin_mg: coeff * 3.4,
      pyridoxine_mg: coeff * 0.38,
      folate_ug: coeff * 54,
      vitamin_b12_ug: coeff * 7,
      vitamin_a_iu: coeff * 1250,
      vitamin_e_mg: coeff * 0.8 * 12.5,
      vitamin_d_iu: coeff * 125
      }
    end
    return req
  end
end
