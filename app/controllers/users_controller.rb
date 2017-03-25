class UsersController < ApplicationController
  before_action :find_user, except: [:index, :home, :new_message]

  def show
    @user = User.find(params[:id])
    @updates = @user.likes.order('created_at desc')
  end

  def index
    @artists = User.all
  end

  def home
    if current_user
      @events = Event.order('created_at desc').take(25)
    else
      redirect_to new_user_session_path
    end
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
    if current_user
      @artist_follow = ArtistFollow.find_or_create_by(follower_id: current_user.id, artist_id: @user.id)
      current_user.events.create(action: 'followed', eventable: @user)
      render :follows
    else
      redirect_to sign_in_path
    end
  end

  def unfollow
    @artist_follow = ArtistFollow.find_by(follower_id: current_user, artist_id: @user)
    @artist_follow.destroy if @artist_follow
    event = Event.find_by(user: current_user, eventable: @user)
    event.destroy if event
    render :follows
  end

  def activity
    @updates = @user.likes.order('created_at desc')
    respond_to do |format|
      format.js
    end
  end

  def posts
    respond_to do |format|
      format.js
    end
  end

  def artworks
    respond_to do |format|
      format.js
    end
  end

  def contact
    @chatroom = Chatroom.create(name: @user.full_name)
    @chatroom_user = @chatroom.chatroom_users.where(user_id: @user.id).first_or_create
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
    redirect_to @chatroom
  end

  private

  def user_params
    params[:user].permit(:name, :hero_image, :profile_image, :email, :full_name, :bio, :website, :instagram_username, :facebook_username, :twitter_username)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
