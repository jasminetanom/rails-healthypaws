module PhotoHelper
  def card_image(recipe)
    image_url = recipe.photo.try(:url) || "http://res.cloudinary.com/tanjamiee/image/upload/v1504175546/default_recipe_photo_160_bjztbo.png"
    url = cl_image_path(image_url, width: 250, height: 250, crop: :fill)

    image_tag url, class: 'card--image'
  end

  def card_image_sm(recipe)
    image_url = recipe.photo.try(:url) || "http://res.cloudinary.com/tanjamiee/image/upload/v1504175546/default_recipe_photo_160_bjztbo.png"
    url = cl_image_path(image_url, width: 250, height: 250, crop: :fill)

    image_tag url, class: 'card--image-sm'
  end

  def dog_card_image(dog)
    image_url = dog.photo.try(:url) || "http://res.cloudinary.com/tanjamiee/image/upload/c_scale,w_510/v1504175546/Default_Dog_Photo_p26jmf.png"
    url = cl_image_path(image_url, width: 200, height: 200, crop: :fill)

    # cl_image_tag(image_url, width: 200, height: 200, crop: :fill)
    image_tag url, class: 'round-image-lg'
  end

  def user_image(user)
    image_url = user.photo.try(:url) || "https://www.1plusx.com/app/mu-plugins/all-in-one-seo-pack-pro/images/default-user-image.png"
    url = cl_image_path(image_url, width: 200, height: 200, crop: :fill)

    # cl_image_tag(image_url, width: 200, height: 200, crop: :fill)
    image_tag url, class: 'round-image-lg'
  end

  def current_user_image
    image_url = current_user.photo.try(:url) || "https://www.1plusx.com/app/mu-plugins/all-in-one-seo-pack-pro/images/default-user-image.png"
    url = cl_image_path(image_url, width: 200, height: 200, crop: :fill)

    # cl_image_tag(image_url, width: 200, height: 200, crop: :fill)
    image_tag url, class: 'round-image-sm avatar dropdown-toggle', id: "navbar-wagon-menu", "data-toggle" => "dropdown"
  end
end

