class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, only: [:like]
  before_action :get_post, only: [:like, :unlike]
  before_action :authenticate_user!, only: [:new, :like]

  def index
    @posts = Post.published.order('published_at desc')
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post created.' }
      else
        format.html { render :new }
      end
    end
  end

  def publishing # rubocop:disable Metrics/MethodLength
    if @post.published?
      flash[:notice] = 'Post already published!'
      render :show
    elsif @post.publish!
      @post.author.events.where(action: 'published', eventable: @post).first_or_create
      flash[:notice] = 'Post published!'
      render :show
    else
      flash[:alert] = 'There was a problem publishing this.'
      render :edit
    end
  end

  def unpublishing # rubocop:disable Metrics/MethodLength
    if @post.draft?
      flash[:notice] = 'Post already a draft!'
      render :show
    elsif @post.unpublish!
      @event = Event.where(user: @post.author, eventable: @post).destroy_all
      flash[:notice] = 'Post unpublished!'
      render :show
    else
      flash[:alert] = 'There was a problem unpublishing this.'
      render :edit
    end
  end

  def like
    @post_like = Like.where(fan: current_user, post: @post).first_or_create
    current_user.events.where(action: 'liked', eventable: @post).first_or_create
    render :likes
  end

  def unlike
    @like = Like.where(fan: current_user, post: @post).destroy_all
    @event = Event.where(user: current_user, eventable: @post).destroy_all
    render :likes
  end

  def update # rubocop:disable Metrics/MethodLength
    if @post.update(post_params)
      if submitting_to_publish?
        redirect_to publishing_post_path(@post)
      elsif submitting_to_unpublish?
        redirect_to unpublishing_post_path(@post)
      else
        respond_to do |format|
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        end
      end
    else
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path }
    end
  end

  private

  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params[:post].permit(:title, :content, :introduction, :featured_image, tag_ids: [])
  end

  def submitting_to_publish?
    params[:commit] == 'Publish'
  end

  def submitting_to_unpublish?
    params[:commit] == 'Unpublish'
  end
end
