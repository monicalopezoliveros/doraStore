class Customer < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Associations
  belongs_to :province
  has_many :orders

  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates :first_name, :last_name, :address, :city, :province_id, :postal_code, presence: true, on: :update

  def full_address
    "#{address}, #{city}, #{province.name}, #{postal_code}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
