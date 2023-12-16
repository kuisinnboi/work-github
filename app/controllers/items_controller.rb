class ItemsController < ApplicationController
  before_action :is_matching_login_user, only: [:show]

  def index
    @items = item.paginate(page: params[:page], per_page: 8)

  end

  def show
  end
end
