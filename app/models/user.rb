# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable # Removed :registerable

  has_many :votes, dependent: :destroy

  def admin?
    role == "admin"
  end
end