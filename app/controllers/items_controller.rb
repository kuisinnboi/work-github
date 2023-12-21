class ItemsController < ApplicationController
  # before_action :is_matching_login_user, only: [:show]

  def index
    @items = Item.paginate(page: params[:page], per_page: 8)
    @genres = Genre.all

  end

  def show
    @item = Item.find(params[:id])
    @cart_items = @item
    @genres = Genre.all
  end
end
