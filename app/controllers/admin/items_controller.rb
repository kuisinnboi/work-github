class Admin::ItemsController < ApplicationController
  
  def index
    records_per_page = 10
    current_page = params[:page].to_i
    current_page = 1 if current_page.zero?
    offset = (current_page - 1) * records_per_page
    @current_page = current_page
    @items = Item.offset(offset).limit(records_per_page)
    @total_pages = (Item.count.to_f / records_per_page).ceil
  end

  def new
    @item = Item.new
    @genre = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @genre = Genre.all
    if @item.save
      redirect_to admin_item_path(@item), notice: "created successfully"
    else
      render new_admin_item_path
    end
  end


  def show
    @item = Item.find(params[:id])

  end

  def edit
    @item = Item.find(params[:id])
    @genre = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    @genre = Genre.all
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "update successfully"
    else
      render edit_admin_item_path(@item)
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name,:introduction,:is_active,:price,:genre_id,:item_image)
  end

end
