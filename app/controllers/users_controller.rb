class UsersController < ApplicationController

  def show
  end

  def index
  end

  private

  def user_params
    params[:user].permit(:name, :email)
  end
end
