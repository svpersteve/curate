class Artwork < ApplicationRecord
  belongs_to :artist, class_name: 'User'
  has_many :artwork_likes, dependent: :destroy
  has_many :fans, through: :artwork_likes, source: :user
  has_many :events, dependent: :destroy, foreign_key: :eventable_id
  has_many :notifications, dependent: :destroy, foreign_key: :notifiable_id

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  mount_uploader :image, ArtworkUploader

  scope :curated, -> { where(curated: true) }
  scope :in_popularity_order, -> { order('artwork_likes_count desc') }

  def label
    name
  end

  def price_in_gbp
    price ? "£#{price}" : nil
  end
end
