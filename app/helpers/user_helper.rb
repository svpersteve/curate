module UserHelper
  def profile_image(user)
    image_tag user.auth_provider_profile_image if user.auth_provider_profile_image.present?
  end

  def instagram_url(user)
    "https://instagram.com/#{user.username}"
  end

  def instagram_link(user)
    link_to "@#{user.username}", instagram_url(user), target: '_blank'
  end
end
