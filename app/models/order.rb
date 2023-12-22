class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  attribute :status, :integer, default: 0

  enum payment_method: { credit_card: 0, transfer: 1 },
       status: { awaiting_payment: 0, payment_confirmed: 1, in_production: 2, preparing_for_shipment: 3, shipped: 4 }

  def full_address
    self.post_code + self.address + self.name
  end

  def subtotal
    item.with_tax_price * amount
  end

end