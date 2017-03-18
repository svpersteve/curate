class User < ApplicationRecord
  rolify

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :tags, foreign_key: :creator_id

  has_many :likes, foreign_key: :fan_id
  has_many :liked_posts, through: :likes, source: :post

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
      user.email = auth.extra.raw_info.email || 'none@provided.com'
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.extra.raw_info.full_name
      first_name, last_name = auth.extra.raw_info.full_name.split
      user.first_name = first_name
      user.last_name = last_name
      user.instagram_username = auth.extra.raw_info.username
      user.username = auth.extra.raw_info.username
      user.bio = auth.extra.raw_info.bio
      user.auth_provider_profile_image = auth.extra.raw_info.profile_picture
    end
  end

  def name
    full_name.split.first
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
