class Item < ApplicationRecord
  has_one_attached :item_image
  belongs_to :genre
  has_many :cart_items
  has_many :order_details
  validates :item_image, presence: true
end
