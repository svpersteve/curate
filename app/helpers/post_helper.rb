module PostHelper
  def post_date(post)
    post.published? ? post.published_at.to_date.to_formatted_s(:long) : "Created on #{post.created_at.to_date.to_formatted_s(:long)}"
  end

  def post_status(post)
    sanitize "<i class='fa fa-lock' title='This post is only visible to you'></i>" if post.draft?
  end
end
