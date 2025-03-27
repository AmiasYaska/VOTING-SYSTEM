class Candidate < ApplicationRecord
  belongs_to :position
  has_many :votes, dependent: :destroy
  
  has_one_attached :photo

  validates :name, presence: true

  # validates :photo, presence: true
  validates :photo, presence: true

  private

  # def photo_format
  #   if photo.byte_size > 5.megabytes
  #     errors.add(:photo, "must be less than 5MB")
  #   end
  # end
end