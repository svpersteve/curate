class User < ApplicationRecord
  rolify

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :tags, foreign_key: :creator_id, dependent: :destroy

  has_many :likes, foreign_key: :fan_id, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :artwork_likes, foreign_key: :user_id, dependent: :destroy
  has_many :liked_artworks, through: :artwork_likes, source: :artwork

  has_many :artist_follows, class_name: "ArtistFollow", foreign_key: "follower_id", dependent: :destroy

  has_many :followed_artists, through: :artist_follows, source: 'artist'

  has_many :followings, class_name: "ArtistFollow", foreign_key: "artist_id", dependent: :destroy

  has_many :followers, through: :followings, source: 'follower'

  has_many :artworks, foreign_key: :artist_id, dependent: :destroy

  has_many :follow_updates, through: :followed_artists, source: :events

  has_many :messages, dependent: :destroy

  def conversations
    Conversation.where("sender_id = ? OR recipient_id = ?", id, id)
  end

  has_many :events, dependent: :destroy

  has_many :notifications, dependent: :destroy

  mount_uploader :hero_image, HeroUploader
  mount_uploader :profile_image, ProfileImageUploader

  extend FriendlyId
  friendly_id :full_name, use: [:slugged, :finders]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:stripe_connect, :facebook]

  validates :full_name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.extra.raw_info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.extra.raw_info.name
      user.auth_provider_profile_image = auth.info.image
    end
  end

  def name
    full_name.split.first
  end

  def last_name
    full_name.split.last
  end

  def label
    full_name
  end

  def avatar
    if profile_image.present?
      profile_image.url(:profile_image_large)
    elsif auth_provider_profile_image.present?
      auth_provider_profile_image + '?type=large'
    else
      'https://s3.eu-west-2.amazonaws.com/wlcimages/avatar.png'
    end
  end

  def avatar_thumbnail
    profile_image.present? ? profile_image.url(:thumbnail) : auth_provider_profile_image
  end

  def unread_messages_count
    count = 0
    conversations.each do |c|
      count += c.messages.not_sent_by(self).unread.size
    end
    count
  end

  def most_recent_conversation
    conversations.order('updated_at DESC').first
  end

  def payment_enabled?
    access_code.present?
  end
end
