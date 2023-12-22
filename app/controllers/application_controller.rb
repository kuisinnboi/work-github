class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    customers_show_path
  end
end
