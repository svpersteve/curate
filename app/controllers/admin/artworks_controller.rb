class Admin::ArtworksController < Admin::BaseController
  before_action :get_artwork, only: [:update, :destroy]

  def index
    @artworks = Artwork.order('created_at desc')
  end

  def update
    if @artwork.update(artwork_params)
      redirect_to admin_artworks_path, notice: 'Artwork successfully updated.'
    else
      redirect_to admin_artworks_path, notice: 'Artwork could not be updated.'
    end
  end

  def destroy
    @artwork.destroy
    redirect_to admin_artworks_path, notice: 'Artwork successfully deleted.'
  end

  private

  def get_artwork
    @artwork = Artwork.find(params[:id])
  end

  def artwork_params
    params[:artwork].permit(:name, :description, :image, :price, :frame_size)
  end
end
