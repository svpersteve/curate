class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def index
    @artists = User.all
  end

  private

  def user_params
    params[:user].permit(:name, :email, :full_name, :first_name, :last_name, :slug, :username)
  end
end
