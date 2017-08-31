class DogsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.photo = "http://res.cloudinary.com/tanjamiee/image/upload/v1504071221/Default_Dog_ueg4ej.png" if @dog.photo.blank?
    if @dog.save
      reqs = get_reqs(@dog.weight, @dog.multiplier, @dog.life_stage)
      @nutrition_req = NutritionReq.new(dog: @dog)
      reqs.each do |nutrient, amount|
        @nutrition_req[nutrient] = amount
      end
      if @nutrition_req.save
        flash[:notice] = "Based on the info you provided, #{@dog.name} has the daily nutritional requirements as shown next to the bars in the chart below. Go ahead and select some ingredients to start creating your recipe and check if it fulfils #{@dog.name}'s minimum targets!"
        redirect_to new_recipe_path
      else
        format.html { render 'pages/home' }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    else
      render :new
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
