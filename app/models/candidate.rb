class Candidate < ApplicationRecord
  belongs_to :position
  has_many :votes, dependent: :destroy

  validates :name, presence: true
end