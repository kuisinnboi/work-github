class OrdersController < ApplicationController
   before_action :authenticate_customer!, only: [:new, :confirm, :create, :index, :show, :complete]


      def new
          @order = Order.new
      end

      def confirm
          @order = Order.new(order_params)

       @cart_items = CartItem.where(customer_id: current_customer.id)
      @shipping_fee = 800
      @cart_items_price = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
      @total_price = @shipping_fee + @cart_items_price

      @selected_pay_method = params[:order][:payment_method]
      @address_type = params[:order][:address_type]
      case @address_type
      when "customer_address"
        @selected_address = current_customer.post_code + " " + current_customer.address + " " + current_customer.last_name + current_member.first_name
      when "registered_address"
        unless params[:order][:registered_address_id] == ""
          selected = Address.find(params[:order][:registered_address_id])
          @selected_address = selected.post_code + " " + selected.address + " " + selected.name
	 else
	   render :new
	 end
      when "new_address"
        unless params[:order][:new_post_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
	  @selected_address = params[:order][:new_post_code] + " " + params[:order][:new_address] + " " + params[:order][:new_name]
	else
	  render :new
	end
      end

      end

      def create

      end

      def index
        @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc).
      end

      def show
        @order = Order.find(params[:id])
        @order_details= OrderDetail.where(order_id: @order.id)
      end

      def complete
      end
   end

   private
   def order_params
  params.require(:order).permit(:payment_method, :post_code, :address, :name)
  end

  end


