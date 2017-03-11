class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:instagram]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.extra.raw_info.email || 'none@provided.com'
      user.password = Devise.friendly_token[0, 20]
      user.bio = auth.extra.raw_info.bio
      user.auth_provider_profile_image = auth.extra.raw_info.profile_picture
    end
  end
end
