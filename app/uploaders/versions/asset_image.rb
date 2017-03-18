module Versions::AssetImage
  include Versions::Base
  extend ActiveSupport::Concern

  included do
    version :hero, if: :image? do
      process resize_to_fit: [HERO_SIZE[0], -1]
      process optimise_jpg: [{ progressive: true, quality: 76 }], if: :jpeg?
    end

    version :large_hero, if: :image? do
      process resize_to_fit: [LARGE_SIZE[0], -1]
      process optimise_jpg: [{ progressive: true, quality: 76 }], if: :jpeg?
    end

    version :small_hero, if: :image? do
      process resize_to_fit: [SMALL_SIZE[0], -1]
      process optimise_jpg: [{ progressive: true, quality: 76 }], if: :jpeg?
    end
  end
end
