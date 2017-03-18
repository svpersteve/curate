class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :likes
  has_many :fans, through: :likes

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  scope :published, -> { where.not(published_at: nil) }
  scope :draft, -> { where(published_at: nil) }
  scope :featured, -> { where(featured: true) }

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
end
