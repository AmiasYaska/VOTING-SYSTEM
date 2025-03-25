class Position < ApplicationRecord
    has_many :candidates, dependent: :destroy
    has_many :votes, dependent: :destroy
  
    validates :name, presence: true
    validates :max_winners, numericality: { greater_than_or_equal_to: 1 }
    validates :priority, presence: true, uniqueness: true
end