class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if user_signed_in?
      redirect_to :recipe_book
    end
    @user = current_or_guest_user
    @dog = Dog.new(user: @user)
  end

  def dashboard
  end

  def recipe_book
    @user = current_user
    if @user.dog.present?
      @recipes = @user.dog.recipes
    else
      @recipes = []
    end
  end
end
