class Admin::OrderDetailsController < Admin::ApplicationController
  def update
    @order = Order.find(params[:id])
    @order_detail = @order.order_details.find(params[:detail_id])
    if @order_detail.update(order_detail_params)
      if @order.order_details.all? { |detail| detail.making_status == "製作完了" }
        @order.update(status: 3)
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
