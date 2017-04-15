class Notification < ApplicationRecord
  belongs_to :notified_by, class_name: 'User'
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read: false) }
  scope :read, -> { where(read: true) }

  def emoji
    if notifiable_type == 'Post'
      "📝"
    elsif notifiable_type == 'Artwork'
      "🖼"
    else
      "👋🏽"
    end
  end
end
