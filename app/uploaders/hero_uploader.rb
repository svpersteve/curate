class HeroUploader < ImageUploader
  include Curate::ImageQuality
  process :set_content_type

  version :thumbnail do
    process resize_to_fill: [300, 200]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :regular do
    process resize_to_fill: REGULAR_SIZE
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :hero do
    process resize_to_fill: SHORT_HERO_SIZE
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :promo_small do
    process resize_to_fill: [900, 360]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :promo_medium do
    process resize_to_fill: [1250, 440]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  version :promo_large do
    process resize_to_fill: [1600, 560]
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
