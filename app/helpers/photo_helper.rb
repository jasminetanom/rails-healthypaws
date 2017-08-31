module PhotoHelper
  def card_image(recipe)
    image_url = recipe.photo.try(:url) || "http://res.cloudinary.com/tanjamiee/image/upload/c_crop,h_510,w_510/v1504071220/HealthyPaws_Logo_Flavicon_flattened_ggoqcz.png"
    url = cl_image_path(image_url, width: 250, height: 250, crop: 'fit')

    image_tag url, class: 'card--image'
  end

  def dog_card_image(dog)
    image_url = dog.photo.try(:url) || "http://res.cloudinary.com/tanjamiee/image/upload/c_crop,h_510,w_510/v1504071221/Default_Dog_ueg4ej.png"
    url = cl_image_path(image_url, width: 250, height: 250, crop: 'fit')

    image_tag url, class: 'card--image'
  end
end

