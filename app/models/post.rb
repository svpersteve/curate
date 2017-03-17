class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
end
