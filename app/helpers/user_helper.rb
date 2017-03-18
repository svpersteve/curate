module UserHelper
  def profile_image(user, css_class: nil)
    attributes = {
      alt: user.full_name,
      class: css_class,
      title: user.full_name
    }

    image_tag(user.avatar, attributes)
  end

  def avatar_small(user, css_class: nil)
    attributes = {
      alt: user.full_name,
      class: css_class,
      title: user.full_name
    }

    image_tag(user.avatar_thumbnail, attributes)
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
