class ArtworkLike < ApplicationRecord
  belongs_to :user
  belongs_to :artwork, counter_cache: true
end
