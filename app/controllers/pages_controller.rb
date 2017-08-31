class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @recipes = Recipe.order(created_at: :desc).limit(15)
    if user_signed_in?
      redirect_to :recipe_book
    end
    @user = current_or_guest_user
    @dog = Dog.new(user: @user)
  end

  def dashboard
    @user = current_user
    if @user.dog.present?
      @dog = @user.dog
      @recipes = @dog.recipes
      @nutrition_req = @dog.nutrition_req
      @nutrients = %w(energy_kcal protein_g fat_g fiber_g calcium_mg iron_mg magnesium_mg phosphorus_mg potassium_mg sodium_mg zinc_mg thiamin_mg riboflavin_mg niacin_mg pyridoxine_mg folate_ug vitamin_b12_ug vitamin_a_iu vitamin_e_mg vitamin_d_iu)
    else
      @recipes = []
    end

  end

  def recipe_book
    @user = current_user
    if @user.dog.present?
      @recipes = @user.dog.recipes
      @favorite_recipes = @user.favorite_recipes
    else
      @recipes = []
      @favorite_recipes = []
    end
  end
end
