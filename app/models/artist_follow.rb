class ArtistFollow < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: :follower_id
  belongs_to :artist, class_name: 'User', foreign_key: :artist_id
end
