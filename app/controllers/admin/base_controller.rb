class Admin::BaseController < ApplicationController
  before_filter :verify_admin
  layout 'admin'

  private

  def verify_admin
    if current_user
      redirect_to root_url unless current_user.has_role? :admin
    else
      redirect_to root_url
    end
  end
end
