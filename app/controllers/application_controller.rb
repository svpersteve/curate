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
    if current_user.email =~ %r{changeme.com}
      request_email_path
    else
      session[:previous_url] || updates_path
    end
  end
end
