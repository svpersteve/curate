class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:instagram]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.extra.raw_info.email || 'none@provided.com'
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.extra.raw_info.full_name
      first_name, last_name = split_name(auth.extra.raw_info.full_name)
      user.first_name = first_name
      user.last_name = last_name
      user.username = auth.extra.raw_info.username
      user.slug = auth.extra.raw_info.username
      user.bio = auth.extra.raw_info.bio
      user.auth_provider_profile_image = auth.extra.raw_info.profile_picture
    end
  end

  def self.split_name(user_full_name)
    user_full_name.split
  end
end
