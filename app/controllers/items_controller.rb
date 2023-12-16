class ItemsController < ApplicationController
  
  def index
    @items = item.paginate(page: params[:page], per_page: 8)
    @posts = Post.all.page(params[:page]).per(8)
  end

  def show
  end
end
