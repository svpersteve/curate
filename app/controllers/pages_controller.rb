class PagesController < ApplicationController
  def index
    @featured_posts = Post.published.featured.order('published_at desc')
  end
end
