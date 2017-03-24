class Artwork < ApplicationRecord
  belongs_to :artist, class_name: 'User'

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  mount_uploader :image, ArtworkUploader

  def label
    name
  end
end
