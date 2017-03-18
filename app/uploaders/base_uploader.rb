class BaseUploader < CarrierWave::Uploader::Base
  def never_destroy_assets
    @file = nil
    @cache_id = nil
  end
  alias_method :remove!, :never_destroy_assets

  before :cache, :generate_uuid

  def generate_uuid(file)
    self.model_uuid = Curate::Random.adblocker_safe_uuid
  end

  def model_uuid=(uuid)
    model.__send__("#{uuid_column_name}=", uuid)
  end

  def model_uuid
    model.__send__(uuid_column_name)
  end

  def uuid_column_name
    [mounted_as, 'uuid'].join('_')
  end

  def store_dir
    uuid = model_uuid
    first_sub_directory = uuid[0..1]
    second_sub_directory = uuid[2..3]

    "uploads/#{first_sub_directory}/#{second_sub_directory}"
  end

  def filename(*args)
    if original_filename.present?
      [file_basename, model_uuid].join('-') + file_extension
    end
  end

  private

  def file_basename
    File.basename(original_filename, '.*')
  end

  def file_extension
    File.extname(original_filename)
  end
end
