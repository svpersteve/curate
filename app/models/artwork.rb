class Artwork < ApplicationRecord
  belongs_to :artist, class_name: 'User'
  has_many :artwork_likes
  has_many :fans, through: :artwork_likes, source: :user

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  mount_uploader :image, ArtworkUploader

  def label
    name
  end

  def price_in_gbp
    price ? "£#{price}" : nil
  end
end
