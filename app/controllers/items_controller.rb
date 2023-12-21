class ItemsController < ApplicationController
  # before_action :is_matching_login_user, only: [:show]

  def index
    @items = Item.paginate(page: params[:page], per_page: 8)

  end

  def show
    @item = Item.find(params[:id])
    @cart_items = CartItem
  end

  private

  def item_params
    params.require(:items).permit(:genre_id,:name,:introduction,:is_active,:price)
  end
end
