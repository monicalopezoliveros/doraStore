class Customer < ApplicationRecord
  # Associations
  belongs_to :province
  has_many :orders

  # Validations
  validates :first_name, :last_name, :email, :address, :city, :province_id, :password, :postal_code, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def full_address
     "#{address}, #{city}, #{province.name}, #{postal_code}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
  # validates :postal_code, format: { with: /\A[0-9A-Za-z]{3,10}\z/, message: "is invalid" }
  # validates :gender, inclusion: { in: %w[male female other], message: "is not valid" }, allow_blank: true
end
