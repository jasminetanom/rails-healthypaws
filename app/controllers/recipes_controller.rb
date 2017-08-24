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
  end

  def create
    @user = current_or_guest_user
    @nutrition_req = @user.dog.nutrition_req
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to dashboard_path, notice: 'Recipe created'
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
