module ApplicationHelper
  def set_page_title(title)
    @page_title = "#{title} | Curate"
  end

  def excerpt(text, length = 250)
    simple_format(truncate(sanitize(text), length: length, escape: false, omission: '...'))
  end
end
