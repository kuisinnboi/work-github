class CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :is_matching_login_customer

  def show
    @customer = Customer.find(params[:id])
    @addresses = @customer.addresses
    @orders = @customer.orders
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

  private

  def is_matching_login_customer
    unless current_customer.id.to_s == params[:id]
      redirect_to root_path, alert: "アクセス権限がありません"
  　end
  end
end
end
