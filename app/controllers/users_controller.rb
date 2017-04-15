class UsersController < ApplicationController
  before_action :find_user, except: [:index, :home, :new_message, :request_email]
  before_action :authenticate_user!, only: [:home, :follow, :unfollow, :contact]

  def show
    @user = User.find(params[:id])
    @updates = @user.likes.order('created_at desc')
  end

  def index
    @artists = User.all
  end

  def home
    @follow_updates = current_user.follow_updates.order('created_at desc').take(25)
  end

  def edit
    authorize! :edit, @user
  end

  def update
    authorize! :manage, @user
    if @user.update(user_params)
      redirect_to user_path(user_params)
    else
      flash[:alert] = I18n.t('user.update.failure')
      render :edit
    end
  end

  def follow
    @artist_follow = ArtistFollow.find_or_create_by(follower_id: current_user.id, artist_id: @user.id)
    current_user.events.create(action: 'followed', eventable: @user)
    @user.artist_follows_count += 1
    create_follow_notification(@user)
    render :follows
  end

  def unfollow
    @artist_follow = ArtistFollow.find_by(follower_id: current_user, artist_id: @user)
    @artist_follow.destroy if @artist_follow
    event = Event.find_by(user: current_user, eventable: @user)
    event.destroy if event
    @user.artist_follows_count -= 1
    delete_follow_notification(@user)
    render :follows
  end

  private

  def user_params
    params[:user].permit(:name, :hero_image, :profile_image, :city, :country_number, :email, :full_name, :bio, :description, :website, :instagram_username, :facebook_username, :twitter_username)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def create_follow_notification(user)
    Notification.create(user: user, notified_by: current_user, notifiable: user, action: 'followed')
  end

  def delete_follow_notification(user)
    notification = Notification.find_by(user_id: user.id, notified_by_id: current_user.id, notifiable_id: user.id, notifiable_type: 'User')
    notification.destroy if notification.present?
  end
end
