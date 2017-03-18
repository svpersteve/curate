module UserHelper
  def profile_image(user)
    image_tag user.auth_provider_profile_image if user.auth_provider_profile_image.present?
  end

  def instagram_url(user)
    "https://instagram.com/#{user.instagram_username}"
  end

  def instagram_link(user)
    if user.instagram_username.present?
      link_to "@#{user.instagram_username}", instagram_url(user), target: '_blank'
    else
      "@#{user.username}"
    end
  end

  def user_likes_post?(user, post)
    post.fans.any? { |f| f == user }
  end
end

