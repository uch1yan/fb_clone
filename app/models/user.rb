class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }

  has_secure_password
  validates :password, length: { minimum: 6 }
  has_many :feeds
end
