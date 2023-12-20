class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
  end
  
  def show
    @customer = Customer.find(params[:id])
    @orders = @customer.orders.all
    records_per_page = 10
    current_page = params[:page].to_i
    current_page = 1 if current_page.zero?
    offset = (current_page - 1) * records_per_page
    @current_page = current_page
    @orders = @customer.orders.offset(offset).limit(records_per_page)
    @total_pages = (@customer.orders.count.to_f / records_per_page).ceil
  end
end
