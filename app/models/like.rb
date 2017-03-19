class Like < ApplicationRecord
  belongs_to :fan, class_name: 'User'
  belongs_to :post

  def subject
    post
  end

  def subject_name
    post.title
  end

  def subject_type
    'post'
  end

  def subject_creator
    post.author
  end
end
