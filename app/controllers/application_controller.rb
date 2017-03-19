class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_action :store_location

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, notice: exception.message
  end

  if Rails.env.production?
    force_ssl
  end

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ %r{/users}
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end
end
