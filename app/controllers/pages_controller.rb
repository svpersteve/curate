class PagesController < ApplicationController
  def index
    @featured_posts = Post.published.featured.order('published_at desc')
    @featured_artworks = Artwork.curated.order('artwork_likes_count desc')
  end
end
