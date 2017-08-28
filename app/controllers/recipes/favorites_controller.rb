class Recipes::FavoritesController < ApplicationController
  def update
    @recipe = Recipe.find(params[:recipe_id])
    Favorite.find_or_create_by(user: current_user, recipe: @recipe)

    render :ok, json: {}
  end
end
