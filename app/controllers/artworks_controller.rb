class ArtworksController < ApplicationController
  load_and_authorize_resource
  before_action :find_artwork, only: [:show, :like, :unlike]
  before_action :authenticate_user!, only: [:like]

  def show
    @artwork = Artwork.find(params[:id])
    @user = @artwork.artist
  end

  def index
    @artworks = Artwork.all
  end

  def new
    @artwork = Artwork.new
  end

  def create
    @artwork = Artwork.new(artwork_params)
    @artwork.artist_id = current_user.id

    respond_to do |format|
      if @artwork.save
        current_user.events.create(action: 'listed', eventable: @artwork)
        format.html { redirect_to @artwork, notice: 'Artwork created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    if @artwork.update(artwork_params)
      respond_to do |format|
        format.html { redirect_to @artwork, notice: "We've updated your artwork." }
      end
    else
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end

  def destroy
    @artwork.destroy
    respond_to do |format|
      format.html { redirect_to artworks_path }
    end
  end

  def like
    @artwork_like = ArtworkLike.where(user: current_user, artwork: @artwork).first_or_create
    @event = current_user.events.where(action: 'liked', eventable: @artwork).first_or_create
    render :likes
  end

  def unlike
    @artwork_like = ArtworkLike.where(user: current_user.id, artwork: @artwork).destroy_all
    @event = Event.where(user: current_user, eventable: @artwork).destroy_all
    render :likes
  end

  private

  def find_artwork
    @artwork = Artwork.find(params[:id])
  end

  def artwork_params
    params[:artwork].permit(:name, :description, :image, :price)
  end
end
