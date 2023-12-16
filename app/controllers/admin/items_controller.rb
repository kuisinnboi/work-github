class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item), notice: "created successfully"
    else
      render 'new'
    end
  end


  def show
    @item = Item.find(params[:id])

  end

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item), notice: "update successfully"
    else
      render "edit"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name,:introduction,:is_active,:price)
  end

end
