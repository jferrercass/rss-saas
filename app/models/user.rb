class User < ApplicationRecord
  belongs_to :organization
  has_secure_password
  enum role: { admin: 0, member: 1 }
  validates :email, presence: true, uniqueness: { scope: :organization_id }
end