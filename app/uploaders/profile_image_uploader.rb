class ProfileImageUploader < ImageUploader
  include Curate::ImageQuality

  version :thumbnail do
    process resize_to_fill: [44, 44]
  end

  version :profile_image do
    process resize_to_fill: [200, 200]
  end
end
