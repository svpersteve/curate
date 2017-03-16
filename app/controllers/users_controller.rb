class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :find_user, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def index
    @artists = User.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(user_params)
    else
      render :edit
    end
  end

  private

  def user_params
    params[:user].permit(:name, :email, :full_name, :first_name, :last_name, :username, :bio)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
