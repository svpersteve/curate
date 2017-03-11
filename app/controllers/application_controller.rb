class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, notice: exception.message
  end

  protect_from_forgery with: :exception

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath match? %r{/users}
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || user_path(current_user)
  end
end
