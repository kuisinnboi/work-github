class Item < ApplicationRecord
  has_one_attached :item_image
  belongs_to :genre
  belongs_to :cart_item
  has_many :order_details
end
