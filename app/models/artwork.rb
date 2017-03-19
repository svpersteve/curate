class Artwork < ApplicationRecord
  belongs_to :artist, class_name: 'User'

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
