class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :new, :create, :show]

  before_action :check_if_user_has_recipe, only: :show
  before_action :authenticate_user!, if: :has_recipe?, only: :show

  def index
      @user = current_user
      non_guest_users = User.where.not(first_name: 'guest', last_name: 'guest').includes(:recipes)
      @recipes = non_guest_users.map(&:recipes).flatten
  end

  def show
    @recipe = Recipe.find(params[:id])
    @nutrients = %w(energy_kcal protein_g fat_g calcium_mg iron_mg magnesium_mg phosphorus_mg potassium_mg sodium_mg zinc_mg thiamin_mg riboflavin_mg niacin_mg pyridoxine_mg folate_ug vitamin_b12_ug vitamin_a_iu vitamin_e_mg vitamin_d_iu)
    @recipe_nutrition_info = RecipeNutritionInfo.find_by(recipe_id: @recipe.id)

    @is_recipe_favorited = current_user && Favorite.find_by(user: current_user, recipe: @recipe).present?
  end

  def new
    @user = current_or_guest_user
    if @user.dog.present?
      @recipe = Recipe.new(dog: @user.dog)
      @nutrition_req = @user.dog.nutrition_req
      @nutrients = %w(energy_kcal protein_g fat_g calcium_mg iron_mg magnesium_mg phosphorus_mg potassium_mg sodium_mg zinc_mg thiamin_mg riboflavin_mg niacin_mg pyridoxine_mg folate_ug vitamin_b12_ug vitamin_a_iu vitamin_e_mg vitamin_d_iu)
    else
      redirect_to new_dog_path
    end
  end

  def create
    @user = current_or_guest_user
    @nutrition_req = @user.dog.nutrition_req
    @nutrients = %w(energy_kcal protein_g fat_g calcium_mg iron_mg magnesium_mg phosphorus_mg potassium_mg sodium_mg zinc_mg thiamin_mg riboflavin_mg niacin_mg pyridoxine_mg folate_ug vitamin_b12_ug vitamin_a_iu vitamin_e_mg vitamin_d_iu)
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      @recipe_nutrition_info = RecipeNutritionInfo.new(recipe_id: @recipe.id)
      if @recipe.doses.any?
        @recipe.doses.each do |dose|
          amount = dose["amount"]
          ingredient = Ingredient.find(dose["ingredient_id"].to_i)
          @nutrients.each do |nutrient|
            @recipe_nutrition_info[nutrient] += (ingredient[nutrient] * amount)
          end
        end
      end
      if @recipe_nutrition_info.save
        redirect_to recipe_path(@recipe), notice: 'Congrats! You\'ve successfully created a recipe.'
      else
        render :new
      end
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_book_path
    else
      render :update
    end
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
      :photo, :photo_cache,
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
