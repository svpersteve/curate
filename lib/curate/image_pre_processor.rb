module Curate
  module ImagePreProcessor
    include CarrierWave::MiniMagick

    def process_image
      optimise
    end

    private

    def optimise
      manipulate! do |img|
        img.combine_options do |c|
          c.profile.try(:+, "!xmp,*")
          c.profile "#{Rails.root}/vendor/sRGB_v4_ICC_preference_displayclass.icc"
          c.colorspace "sRGB"
          c.auto_orient
          c.strip
        end
        img
      end
    end
  end
end
