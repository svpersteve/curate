class FeaturedImageUploader < ImageUploader
  include Curate::ImageQuality
  process :set_content_type

  version :twitter do
    process resize_to_fill: [280, 180]
    process optimise_jpg: [{ progressive: true, quality: 76 }]
  end

  def filename(*args)
    model_uuid + ".jpg" if original_filename.present?
  end

  def set_content_type
    file.content_type = 'image/jpg'
  end
end
