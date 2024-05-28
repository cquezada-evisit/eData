module UuidGenerator
  extend ActiveSupport::Concern

  included do
    before_create :set_uuid
  end

  private

  def set_uuid
    self.id = SecureRandom.uuid
  end
end
