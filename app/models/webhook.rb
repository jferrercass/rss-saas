class Webhook < ApplicationRecord
  belongs_to :organization
  belongs_to :feed, optional: true
    
  validates :url, presence: true
end