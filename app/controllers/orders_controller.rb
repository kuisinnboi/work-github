class OrdersController < ApplicationController
   before_action :authenticate_customer!, only: [:new, :confirm, :create, :index, :show, :complete]


      def new
      end

      def confirm

      end

      def create

      end

      def index
        @orders = Order.where(member_id: current_member.id).order(created_at: :desc).
      end

      def show
        @order = Order.find(params[:id])
        @order_details= OrderDetail.where(order_id: @order.id)
      end

      def complete
      end
   end
  end


