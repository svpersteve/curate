class User < ApplicationRecord
  rolify

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :tags, foreign_key: :creator_id

  has_many :likes, foreign_key: :fan_id
  has_many :liked_posts, through: :likes, source: :post

  has_many :artwork_likes, foreign_key: :user_id
  has_many :liked_artworks, through: :artwork_likes, source: :artwork

  has_many :artist_follows, class_name:  "ArtistFollow",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

  has_many :followed_artists, through: :artist_follows, source: 'artist'

  has_many :followings, class_name:  "ArtistFollow",
                                  foreign_key: "artist_id",
                                  dependent:   :destroy

  has_many :followers, through: :followings, source: 'follower'

  has_many :artworks, foreign_key: :artist_id

  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages

  has_many :events, dependent: :destroy

  mount_uploader :hero_image, HeroUploader
  mount_uploader :profile_image, ProfileImageUploader

  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:instagram]

  validates :full_name, presence: true
  validates :username, presence: true
  validates_uniqueness_of :username, case_sensitive: false

  def self.from_omniauth(auth) # rubocop:disable Metrics/MethodLength
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.extra.raw_info.email || "#{auth.extra.raw_info.username}@changeme.com"
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.extra.raw_info.full_name
      user.instagram_username = auth.extra.raw_info.username
      user.username = auth.extra.raw_info.username
      user.bio = auth.extra.raw_info.bio
      user.auth_provider_profile_image = auth.extra.raw_info.profile_picture
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
      profile_image.url(:profile_image)
    elsif auth_provider_profile_image.present?
      auth_provider_profile_image
    else
      'https://s3.eu-west-2.amazonaws.com/wlcimages/avatar.png'
    end
  end

  def avatar_thumbnail
    profile_image.present? ? profile_image.url(:thumbnail) : auth_provider_profile_image
  end
end
