class PagesController < ApplicationController
  def index
    @featured_posts = Post.published.featured.order('published_at desc')
    @featured_artworks = Artwork.curated.order('artwork_likes_count desc')
    @homepage_wallpaper = Wallpaper.find_by(location: 'Homepage').image
    @events_wallpaper = Wallpaper.find_by(location: 'Events banner').image
  end

  def events
    @events_wallpaper = Wallpaper.find_by(location: 'Events banner').image
  end
end
