class CartItemsController < ApplicationController

  def index
    @cart_item = current_customer.cart_item
    @item = @@cart_item.item
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  def create

  end
end
