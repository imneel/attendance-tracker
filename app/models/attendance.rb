class Attendance < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :date, presence: true, uniqueness: { scope: :user_id, message: "You have checked-in already" }
  validates :tod, presence: true

  serialize :tod, Tod::TimeOfDay
  # paginate_per 50
end
