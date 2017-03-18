module Curate::Uuid
  extend ActiveSupport::Concern

  included do
    before_create :uuid
  end

  def uuid
    super || self.uuid = SecureRandom.uuid
  end
end
