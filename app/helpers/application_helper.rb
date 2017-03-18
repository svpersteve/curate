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

  def list_all_sentence(users)
    users.map { |u| link_to(u.name, user_path(u)) }.to_sentence
  end

  def list_all(users)
    users.map { |u| link_to(u.name, user_path(u)) }.join(', ')
  end

  def likes_count(subject)
    case subject.likes.count
    when 0
      "0 likes"
    when 1..3
      "liked by #{list_all_sentence(subject.fans)}".html_safe
    else
      "liked by #{list_all(subject.fans.take(3))} and #{remaining_like_count(subject)}".html_safe
    end
  end

  def remaining_like_count(subject)
    pluralize((subject.likes.count - 4), 'other person')
  end

  def relative_time(date)
    sentence = time_ago_in_words(date)
    sentence.slice(0, 1).capitalize + sentence.slice(1..-1)
  end

  def time_as_sentence(date)
    date.past? ? "#{relative_time(date)} ago" : "In #{relative_time(date)}"
  end

  def date_and_time_as_sentence(date)
    "#{time_as_sentence(date)}, #{date.to_date.to_formatted_s(:short)}"
  end
end
