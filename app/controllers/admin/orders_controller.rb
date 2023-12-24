
class Admin::OrdersController < Admin::ApplicationController
  def show
    @order= Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
      if @order.status == "payment_confirmed"
        @order_details.each do |order_detail|
          order_detail.update(making_status: 1)
        end
      end
      redirect_to admin_order_path(@order), notice: "変更を完了しました"
    else
      render admin_order_path(@order)
    end
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
