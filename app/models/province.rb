class Province < ApplicationRecord
  # Associations
  has_many :customers

  # Validations to ensure that taxes are numeric or null values
  validates :gst, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :pst, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :hst, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Methods to return the tax value if it is N/A
  def gst_value
    gst.present? ? gst : 0.0
  end

  def pst_value
    pst.present? ? pst : 0.0
  end

  def hst_value
    hst.present? ? hst : 0.0
  end
end