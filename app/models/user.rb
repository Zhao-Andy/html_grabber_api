class User < ApplicationRecord
  has_many :content

  validates :email, presence: true, uniqueness: true
  validates :api_key, presence: true, uniqueness: true
end
