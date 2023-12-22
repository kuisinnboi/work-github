class Admin::CustomersController < Admin::ApplicationController

  def index
    records_per_page = 10
    current_page = params[:page].to_i
    current_page = 1 if current_page.zero?
    offset = (current_page - 1) * records_per_page
    @current_page = current_page
    @customers = Customer.offset(offset).limit(records_per_page)
    @total_pages = (Customer.count.to_f / records_per_page).ceil
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "update successfully"
    else
      render edit_admin_customer_path(@customer)
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:post_code,:address,:telephone_number,:email,:is_active)
  end
end
