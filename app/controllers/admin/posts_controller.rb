class Admin::PostsController < Admin::BaseController
  before_action :get_post, only: [:update, :destroy]

  def index
    @posts = Post.order('created_at desc')
  end

  def update # rubocop:disable Metrics/MethodLength
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: 'Post was successfully updated.'
    else
      redirect_to admin_posts_path, notice: 'Post could not be updated.'
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { render :index }
    end
  end

  private

  def get_post
    @post = Post.find(params[:id])
  end

  def post_params
    params[:post].permit(:title, :content, :introduction, :featured, :featured_image, tag_ids: [])
  end
end
