class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  scope :published, -> { where.not(published_at: nil) }
  scope :draft, -> { where(published_at: nil) }

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
