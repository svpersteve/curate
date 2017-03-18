module Curate
  autoload :Uuid, 'curate/uuid'
  autoload :Random, 'curate/random'
  autoload :ImageQuality, 'future_learn/image_quality'
  autoload :ImagePreProcessor, 'future_learn/image_pre_processor'

  class << self
    def config
      Railtie.config.future_learn
    end

    def debug_logger
      config.debug_logger
    end
  end
end
