class Recipes::UnfavoritesController < ApplicationController
  def update
    @recipe = Recipe.find(params[:recipe_id])
    @favorite = Favorite.find_by(user: current_user, recipe: @recipe)
    @favorite.delete

    render :ok, json: {}
  end
end
