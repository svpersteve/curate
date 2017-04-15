class Admin::WallpapersController < Admin::BaseController
  before_action :get_wallpaper, only: [:show, :edit, :update, :destroy]

  def index
    @wallpapers = Wallpaper.all
  end

  def new
    @wallpaper = Wallpaper.new
  end

  def create
    @wallpaper = Wallpaper.new(wallpaper_params)

    respond_to do |format|
      if @wallpaper.save
        format.html { redirect_to admin_wallpapers_path, notice: 'Wallpaper created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    if @wallpaper.update(wallpaper_params)
      redirect_to admin_wallpapers_path, notice: 'Wallpaper successfully updated.'
    else
      redirect_to admin_wallpapers_path, notice: 'Wallpaper could not be updated.'
    end
  end

  def destroy
    @wallpaper.destroy
    redirect_to admin_wallpapers_path, notice: 'Wallpaper successfully deleted.'
  end

  private

  def get_wallpaper
    @wallpaper = Wallpaper.find(params[:id])
  end

  def wallpaper_params
    params[:wallpaper].permit(:name, :image, :location)
  end
end
