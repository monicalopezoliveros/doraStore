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

  # Method for calculating taxes according to province
  def calculate_taxes(subtotal)
    gst_rate = province.gst.to_f
    pst_rate = province.pst.to_f
    hst_rate = province.hst.to_f

    gst_amount = gst_rate > 0 ? (subtotal * gst_rate) : 0
    pst_amount = pst_rate > 0 ? (subtotal * pst_rate) : 0
    hst_amount = hst_rate > 0 ? (subtotal * hst_rate) : 0

    gst_amount + pst_amount + hst_amount
  end
end
