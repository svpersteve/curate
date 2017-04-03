class Admin::UsersController < Admin::BaseController
  before_action :get_user, only: [:update, :destroy]

  def index
    @users = User.order('created_at desc')
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User successfully updated.'
    else
      redirect_to admin_users_path, notice: 'User could not be updated.'
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User successfully deleted.'
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params[:user].permit(:name, :hero_image, :profile_image, :email, :full_name, :bio, :description, :website, :instagram_username, :facebook_username, :twitter_username)
  end
end
