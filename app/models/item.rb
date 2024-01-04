class Item < ApplicationRecord
  has_one_attached :item_image
  belongs_to :genre
  has_many :cart_items
  has_many :order_details
  validates :item_image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  attribute :is_active, :boolean, default: true
  validates :price, presence: true

  def with_tax_price
    (price * 1.1).floor
  end

end
