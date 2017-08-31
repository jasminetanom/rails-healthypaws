class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user.dog.present?
      @dog = @user.dog
      @recipes = @dog.recipes
      @nutrition_req = @dog.nutrition_req
      @nutrients = %w(energy_kcal protein_g fat_g calcium_mg iron_mg magnesium_mg phosphorus_mg potassium_mg sodium_mg zinc_mg thiamin_mg riboflavin_mg niacin_mg pyridoxine_mg folate_ug vitamin_b12_ug vitamin_a_iu vitamin_e_mg vitamin_d_iu)
    else
      @recipes = []
    end
  end
end

