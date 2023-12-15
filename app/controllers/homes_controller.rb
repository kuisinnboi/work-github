class HomesController < ApplicationController
  def top
    @items = Item.order('id DESC').limit(4)
    # ASCだと古い順でDESCで新着順です。
  end

  def about
  end
end
