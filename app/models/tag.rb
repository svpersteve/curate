class Tag < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :post_tags
  has_many :posts, through: :post_tags

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
