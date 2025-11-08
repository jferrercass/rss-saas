class Organization < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :feeds, dependent: :destroy
  has_many :api_keys, dependent: :destroy
  has_many :webhooks, dependent: :destroy
    
  validates :name, presence: true
end