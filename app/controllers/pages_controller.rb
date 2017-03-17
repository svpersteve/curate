class PagesController < ApplicationController
  def index
    @featured_posts = Post.published.featured
  end
end
