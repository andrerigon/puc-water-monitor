class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :name, presence: true
  validates :phone_number, presence: true

  # Check if the user is an admin
  def admin?
    self.admin
  end
end