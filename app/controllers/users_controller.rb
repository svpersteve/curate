class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :find_user, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
    @updates = @user.likes.order('created_at desc')
  end

  def index
    @artists = User.all
  end

  def home
    if current_user
      @updates = Like.order('created_at desc')
    else
      redirect_to new_user_session_path
    end
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

  def activity
    respond_to do |format|
      format.js
    end
  end

  def posts
    respond_to do |format|
      format.js
    end
  end

  private

  def user_params
    params[:user].permit(:name, :hero_image, :profile_image, :email, :full_name, :bio, :website, :instagram_username, :facebook_username, :twitter_username)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
