class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :telegram_chat_id, presence: true, if: -> { receive_updates? }

  # Check if the user is an admin
  def admin?
    self.admin
  end
end