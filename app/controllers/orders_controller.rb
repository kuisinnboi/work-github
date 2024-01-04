class OrdersController < ApplicationController
  before_action :authenticate_customer!, only: [:new, :confirm, :create, :index, :show, :thanks]

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @shipping_fee = 800
    @subtotal = 0
    # @cart_items.each do |cart_item|
    #   @subtotal += cart_item.subtotal
    # end
    # @total_price = @shipping_fee + @subtotal

    @selected_pay_method = params[:order][:payment_method]
    @address_type = params[:order][:address_type]
    case @address_type
    when "customer_address"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      #@selected_address = current_customer.post_code + " " + current_customer.address + " " + current_customer.last_name + current_customer.first_name
    when "registered_address"
      unless params[:order][:registered_address_id] == ""
        address = Address.find(params[:order][:registered_address_id])
        @order.post_code = address.post_code
        @order.address = address.address
        @order.name = address.name
        #@selected_address = selected.post_code + " " + selected.address + " " + selected.name
      else
    	  render :new
    	end
    when "new_address"
      #@selected_address =@order.post_code + " " + @order.address + " " + @order.name
    else
      render :new
    end
  end

  def error

  end

  def create
    @order = Order.new(order_params)
    @selected_pay_method = params[:order][:payment_method]
    @address_type = params[:order][:address_type]
    @shipping_fee = 800
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item.id
      @order_detail.price = cart_item.item.price
      @order_detail.amount = cart_item.amount

      @order_detail.save
    end
    current_customer.cart_items.destroy_all #カートの中身を削除
    redirect_to thanks_orders_path
  end

  def index
    @orders = current_customer.orders.all
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

      def show
        @order = Order.find(params[:id])
        @cart_items = CartItem.where(customer_id: current_customer.id)

        @order_details = @order.order_details
        @subtotal = 0
      end

      def thanks
      end
   end

   private
   def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :shipping_cost, :total_payment)
   end




