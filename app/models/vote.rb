class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :candidate
  belongs_to :position

  validates :status, inclusion: { in: %w[draft submitted] }
end