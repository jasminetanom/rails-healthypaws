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
    @recipe = Recipe.new
    @nutrition_req = @user.dog.nutrition_req
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
