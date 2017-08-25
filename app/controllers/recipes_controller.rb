class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :new, :create, :show]

  before_action :check_if_user_has_recipe, only: :show
  before_action :authenticate_user!, if: :has_recipe?, only: :show

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @user = current_or_guest_user
    if @user.dog.present?
      @recipe = Recipe.new(dog: @user.dog)
      @nutrition_req = @user.dog.nutrition_req
      @nutrients = %w(energy_kcal protein_g fat_g fiber_g calcium_mg iron_mg magnesium_mg phosphorus_mg potassium_mg sodium_mg zinc_mg thiamin_mg riboflavin_mg niacin_mg pyridoxine_mg folate_ug vitamin_b12_ug vitamin_a_iu vitamin_e_mg vitamin_d_iu)
    else
      redirect_to new_dog_path
    end
  end

  def create
    @user = current_or_guest_user
    @nutrition_req = @user.dog.nutrition_req
    @nutrients = %w(energy_kcal protein_g fat_g fiber_g calcium_mg iron_mg magnesium_mg phosphorus_mg potassium_mg sodium_mg zinc_mg thiamin_mg riboflavin_mg niacin_mg pyridoxine_mg folate_ug vitamin_b12_ug vitamin_a_iu vitamin_e_mg vitamin_d_iu)
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: 'Congrats! You\'ve successfully created a recipe.'
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

  def check_if_user_has_recipe
    dog = current_or_guest_user.dog
    @has_recipe = dog&.recipes&.present?
  end

  def has_recipe?
    !!@has_recipe
  end

  def recipe_params
    recipe_params = params.require(:recipe).permit(
      :name,
      :dog_id,
      doses_attributes: [
        :id,
        :ingredient_id,
        :amount,
        :unit,
        :_destroy
      ]
    )
  end

end
