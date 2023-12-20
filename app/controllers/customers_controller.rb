class CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :is_matching_login_customer

  def show
    @customer = current_customer
    @addresses = @customer.addresses
    @orders = @customer.orders
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer ), notice: "変更内容を保存しました。"
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
  end

  def withdraw
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number, :email)
  end

  def is_matching_login_customer
    unless current_customer.id.to_s == params[:id]
      redirect_to root_path, alert: "アクセス権限がありません"
    end
  end
end
