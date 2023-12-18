class Item < ApplicationRecord
  has_one_attached :item_image
  belongs_to :genre
  has_many :cart_item
  has_many :order_details
end
