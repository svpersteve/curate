class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath match? %r{/users}
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end
end
