class Admin::OrdersController < Admin::ApplicationController
  def show
    @order= Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path(@order), notice: "update successfully"
    else
      render admin_order_path(@order)
    end
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end

end
