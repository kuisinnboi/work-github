class CustomersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @customer = current_user
    @addresses = 
    @orders = 
    
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end
end
