module Versions::Base
  include Curate::ImageQuality

  HERO_SIZE = ImageUploader::HERO_SIZE
  SMALL_SIZE = [320, 213]
  LARGE_SIZE = [729, 486]

  def image?(file)
    true
  end

  def jpeg?(file)
    file.content_type == "image/jpeg"
  end
end
