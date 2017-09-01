class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :new, :create, :show]

  before_action :check_if_user_has_recipe, only: :show
  before_action :authenticate_user!, if: :has_recipe?, only: :show
  before_action :set_ingredients, only: [:new, :create, :edit, :update]

  def index
    @user = current_user
    non_guest_users = User.where.not(first_name: 'guest', last_name: 'guest').includes(:recipes)

    if params[:search] == "true"
      search_recipes = Recipe.where(nil)
      filtering_params(params).each do|key, value|
        search_recipes = Ingredient.find_by(name: value).recipes if value.present?
      end
      @recipes = search_recipes
    else
      @recipes = non_guest_users.map(&:recipes).flatten
    end
  end

  def show
    @user = current_or_guest_user
    @nutrition_req = @user.dog.nutrition_req if @user.dog.present?
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
      @ingredients = Ingredient.order(:name)
    else
      redirect_to new_dog_path
    end
  end

  def create
    @user = current_or_guest_user
    @nutrition_req = @user.dog.nutrition_req
    @nutrients = %w(energy_kcal protein_g fat_g calcium_mg iron_mg magnesium_mg phosphorus_mg potassium_mg sodium_mg zinc_mg thiamin_mg riboflavin_mg niacin_mg pyridoxine_mg folate_ug vitamin_b12_ug vitamin_a_iu vitamin_e_mg vitamin_d_iu)
    @ingredients = Ingredient.order(:name)
    @recipe = Recipe.new(recipe_params)
    @recipe.photo = "http://res.cloudinary.com/tanjamiee/image/upload/v1504071220/HealthyPaws_Logo_Flavicon_flattened_ggoqcz.png" if @recipe.photo.blank?
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

        # puts "111 #{@recipe_nutrition_info.errors.inspect}"
        render :new
      end
    else
      # puts "222 #{@recipe.errors.inspect}"
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @ingredients = Ingredient.order(:name)
  end

  def update
    @recipe = Recipe.find(params[:id])
    @ingredients = Ingredient.order(:name)
    if @recipe.update(recipe_params)
      redirect_to recipe_book_path
    else
      render :update
    end
  end

  def destroy
  end

  private

  def set_ingredients
    @ingredients = Ingredient.order(:name)
  end

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

  def filtering_params(params)
    params.slice(:ingredient)
  end

end
