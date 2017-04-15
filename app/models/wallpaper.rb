class Wallpaper < ApplicationRecord
  mount_uploader :image, WallpaperUploader

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
