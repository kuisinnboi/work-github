class Admin::ApplicationController < ApplicationController
    before_action :require_login 

  private

  def require_login
    unless admin_signed_in?
      flash[:error] = "ログインが必要です"
      redirect_to new_admin_session_path
    end
  end
end
