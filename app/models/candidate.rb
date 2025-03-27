class Candidate < ApplicationRecord
  belongs_to :position
  has_many :votes, dependent: :destroy

  has_one_attached :photo

  validates :name, presence: true

  validates :photo, size: { less_than: 5.megabytes, message: "must be less than 5MB" }
end