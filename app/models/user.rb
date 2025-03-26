class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :lockable, :timeoutable
  
  has_many :votes, dependent: :destroy

  def admin?
    role == "admin"
  end
end