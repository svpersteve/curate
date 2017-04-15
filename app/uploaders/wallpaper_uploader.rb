class WallpaperUploader < ImageUploader
  include Curate::ImageQuality
  process :set_content_type

  version :small do
    process resize_to_fill: [500, 360]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :medium do
    process resize_to_fill: [1000, 720]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :large do
    process resize_to_fill: [2000, 1440]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  def filename(*args)
    model_uuid + ".jpg" if original_filename.present?
  end

  def set_content_type
    file.content_type = 'image/jpg'
  end
end
