class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :lockable
  
  has_many :votes, dependent: :destroy

  def admin?
    role == "admin"
  end
end