class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]+\z/i, message: "Username should contain only alphabet and numbers." }
  has_many :attendances, dependent: :destroy
end
