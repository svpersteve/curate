class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :likes, dependent: :destroy
  has_many :fans, through: :likes
  has_many :events, dependent: :destroy, foreign_key: :eventable_id
  has_many :notifications, dependent: :destroy, foreign_key: :notifiable_id

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  mount_uploader :featured_image, FeaturedImageUploader

  scope :published, -> { where.not(published_at: nil) }
  scope :draft, -> { where(published_at: nil) }
  scope :featured, -> { where(featured: true) }

  def label
    title
  end

  def published?
    published_at.present?
  end

  def publish!
    if published?
      true
    else
      update(published_at: Time.now.utc)
    end
  end

  def draft?
    published_at.nil?
  end

  def unpublish!
    if draft?
      true
    else
      update(published_at: nil)
    end
  end

  def image_preview
    featured_image.url(:twitter) || 'https://s3.eu-west-2.amazonaws.com/curate-group/uploads/images/27/08/twitter_2708db3a-8c91-4115-8f39-499af496fef9.jpg'
  end
end
