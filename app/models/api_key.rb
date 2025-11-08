class ApiKey < ApplicationRecord
  belongs_to :organization
  before_create :generate_key

  def generate_key
    self.key = SecureRandom.hex(32)
  end
end