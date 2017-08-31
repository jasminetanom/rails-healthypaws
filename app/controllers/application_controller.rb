class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  protected

  helper_method :current_or_guest_user

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:first_name, :last_name, :email, :photo, :photo_cache])
  end

# if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      transfer_session_to_logged_in_user if session[:guest_user_id].present?
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(guest_user_id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

  private

  def guest_user_id
    session[:guest_user_id] ||= create_guest_user.id
  end

  def create_guest_user
    u = User.create(:first_name => "guest", :last_name => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    u.save!(:validate => false)
    u
  end

  def transfer_session_to_logged_in_user
    if session[:guest_user_id] != current_user.id
      transfer_dog
      destroy_guest_user
    end
  end

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def transfer_dog
    if guest_user.dog.present?
      guest_dog = guest_user.dog
      current_user.dog.destroy if current_user.dog.present?
      guest_dog.user_id = current_user.id
      guest_dog.save!
    end
  end

  # reload guest_user to prevent caching problems before destruction
  def destroy_guest_user


    guest_user(with_retry = false).try(:reload).try(:destroy)
    session[:guest_user_id] = nil
  end

  def default_url_options
  { host: ENV["HOST"] || "localhost:3000" }
  end

end

