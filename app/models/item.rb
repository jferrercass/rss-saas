class Item < ApplicationRecord
  belongs_to :feed
  validates :guid, uniqueness: { scope: :feed_id }
end