class ApplicationController < ActionController::Base
  before_action :store_current_location, unless: :devise_controller?
  after_filter :store_location

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, notice: exception.message
  end

  protect_from_forgery with: :exception

  def store_current_location
    store_location_for(:user, request.url)
  end

  def store_location
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?)
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  private

  def after_sign_out_path_for(resource)
    request.referrer || root_path
  end
end
