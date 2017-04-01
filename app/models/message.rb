class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id

  scope :unread, -> { where(read: false) }
  scope :not_sent_by, ->(user) { where.not(user: user) }

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
