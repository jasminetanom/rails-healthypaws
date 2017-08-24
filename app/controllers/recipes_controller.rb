class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @user = current_or_guest_user
    @recipe = Recipe.new(dog: @user.dog)
    @nutrition_req = @user.dog.nutrition_req
    @nutrients = %w(energy_kcal protein_g fat_g fiber_g calcium_mg iron_mg magnesium_mg phosphorus_mg potassium_mg sodium_mg zinc_mg thiamin_mg riboflavin_mg niacin_mg pyridoxine_mg folate_ug vitamin_b12_ug vitamin_a_iu vitamin_e_mg vitamin_d_iu)
  end

  def create
    @user = current_or_guest_user
    @nutrition_req = @user.dog.nutrition_req
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: 'Recipe created'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :dog_id,
      doses_attributes: [
        :id,
        :ingredient_id,
        :ingredient,
        :amount,
        :unit,
        :_destroy
      ]
    )
  end

end
