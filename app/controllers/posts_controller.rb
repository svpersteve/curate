class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post.published
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    if current_user
      @post = Post.new
    else
      redirect_to new_user_session_path
    end
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

  def publishing
    if @post.published?
      flash[:notice] = 'Post already published!'
      redirect_to @post
    elsif @post.publish!
      flash[:notice] = 'Post published!'
      redirect_to @post
    else
      flash[:alert] = 'There was a problem publishing this.'
      redirect_to :edit
    end
  end

  def unpublishing
    if @post.draft?
      flash[:notice] = 'Post already a draft!'
      redirect_to @post
    elsif @post.unpublish!
      flash[:notice] = 'Post unpublished!'
      redirect_to @post
    else
      flash[:alert] = 'There was a problem unpublishing this.'
      redirect_to :edit
    end
  end

  def like
    if current_user
      @post_like = Like.find_or_create_by(fan_id: current_user, post_id: @post) do |like|
        like.post = @post
        like.fan = current_user
      end
      render :likes
    else
      redirect_to sign_in_path
    end
  end

  def unlike
    @like = Like.find_by(fan_id: current_user.id, post_id: @post.id)
    @like.destroy
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

  def post_params
    params[:post].permit(:title, :content, :featured, tag_ids: [])
  end

  def submitting_to_publish?
    params[:commit] == 'Publish'
  end

  def submitting_to_unpublish?
    params[:commit] == 'Unpublish'
  end
end
