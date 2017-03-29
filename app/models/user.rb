class User < ApplicationRecord
  has_many :contents

  validates :email, :api_key, presence: true, uniqueness: true
end
