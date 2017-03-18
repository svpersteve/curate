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
      flash[:alert] = I18n.t('user.update.failure')
      render :edit
    end
  end

  private

  def user_params
    params[:user].permit(:name, :hero_image, :email, :full_name, :bio, :instagram_username)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
