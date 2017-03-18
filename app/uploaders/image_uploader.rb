class ImageUploader < BaseUploader
  include CarrierWave::MiniMagick
  include Curate::ImagePreProcessor
  include Curate::Random

  REGULAR_SIZE          = [442, 295]
  HERO_SIZE             = [648, 432]
  MEDIUM_HERO_SIZE      = [648, 280]
  SHORT_HERO_SIZE       = [648, 230]

  process :process_image

  storage :fog

  def store_dir
    uuid = model_uuid
    first_sub_directory = uuid[0..1]
    second_sub_directory = uuid[2..3]

    "uploads/images/#{first_sub_directory}/#{second_sub_directory}"
  end

  def filename(*args)
    model_uuid + File.extname(original_filename) if original_filename.present?
  end

  def extension_white_list
    %w(jpeg jpg png)
  end
end
