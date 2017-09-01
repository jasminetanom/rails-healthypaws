module PhotoHelper
  def card_image(recipe)
    image_url = recipe.photo.try(:url) || "http://res.cloudinary.com/tanjamiee/image/upload/v1504175546/default_recipe_photo_160_bjztbo.png"
    url = cl_image_path(image_url, width: 250, height: 250, crop: 'fit')

    image_tag url, class: 'card--image'
  end

  def dog_card_image(dog)
    image_url = dog.photo.try(:url) || "http://res.cloudinary.com/tanjamiee/image/upload/c_scale,w_510/v1504175546/Default_Dog_Photo_p26jmf.png"
    url = cl_image_path(image_url, width: 250, height: 250, crop: 'fit')

    image_tag url, class: 'card--image'
  end
end

