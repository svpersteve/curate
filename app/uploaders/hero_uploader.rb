class HeroUploader < ImageUploader
  include Curate::ImageQuality
  process :set_content_type

  version :thumbnail do
    process resize_to_fill: [300, 200]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :profile_medium do
    process resize_to_fill: [800, 500]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :header_small do
    process resize_to_fill: [800, 380]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :header_medium do
    process resize_to_fill: [1024, 630]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :header_large do
    process resize_to_fill: [2050, 820]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  def filename(*args)
    model_uuid + ".jpg" if original_filename.present?
  end

  def set_content_type
    file.content_type = 'image/jpg'
  end
end
