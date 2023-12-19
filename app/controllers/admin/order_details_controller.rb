class Admin::OrderDetailsController < ApplicationController
  def update
    @order = Order.find(params[:id])
    @order_detail = @order.order_details
    if @order_detail.update(order_detail_params)
      redirect_to admin_order_path(@order), notice: "update successfully"
    else
      render admin_order_path(@order)
    end
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
