class Feed < ApplicationRecord
  belongs_to :organization
  has_many :items, dependent: :destroy
  enum status: { active: 0, paused: 1, error: 2 }
  validates :url, presence: true
  after_create :enqueue_fetch

  def enqueue_fetch
    FetchFeedJob.perform_later(id)
  end
end