class CustomersController < ApplicationController
  before_action :authenticate_customer!
  # before_action :is_matching_login_customer, except: [:unsubscribe, :withdraw]

  def show
    @customer = current_customer
    @addresses = @customer.addresses
    @orders = @customer.orders
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_show_path, notice: "変更内容を保存しました。"
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number, :email)
  end

  # def is_matching_login_customer
  #   unless current_customer.id.to_s == params[:id]
  #     redirect_to root_path, alert: "アクセス権限がありません"
  #   end
  # end
end
