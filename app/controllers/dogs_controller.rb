class DogsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.photo = "http://res.cloudinary.com/tanjamiee/image/upload/v1504071221/Default_Dog_ueg4ej.png" if @dog.photo.blank?

    if @dog.save
      @nutrition_req = @dog.nutrition_req
      flash[:notice] = "Based on the info you provided, #{@dog.name} has the daily nutritional requirements as shown next to the bars in the chart below. Go ahead and select some ingredients to start creating your recipe and check if it fulfils #{@dog.name}'s minimum targets!"
      redirect_to new_recipe_path
    else
      format.html { render 'pages/home' }
      format.json { render json: @dog.errors, status: :unprocessable_entity }
    end
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def update
    @dog = Dog.find(params[:id])
    if @dog.update(dog_params)
      redirect_to dashboard_path
    else
      render :update
    end
  end

  def destroy
    @dog = Dog.find(params[:id])
    @dog.destroy
  end

  private

  def dog_params
    params.require(:dog).permit(:user_id, :name, :photo, :photo_cache, :weight, :activity_level, :size, :is_sterilized, :life_stage, :body_condition_score)
  end
end
