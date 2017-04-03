module ArtworkHelper
  def frame_size_options_for_select(selected = nil)
    sizes = ['18-32"', '33-47"', '48-62"']
    options_for_select(sizes.map { |s| s }, selected)
  end
end
