module ApplicationHelper
  def set_page_title(title)
    @page_title = "#{title} | Curate"
  end

  def excerpt(text, length = 250)
    simple_format(truncate(sanitize(text), length: length, escape: false, omission: '...'))
  end

  def name_options_for_select(resources, selected = nil)
    options_for_select(resources.map { |r| [r.name, r.id] }, selected)
  end
end
