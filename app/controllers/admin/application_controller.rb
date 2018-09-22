class Admin::ApplicationController < ActionController::Base
  include SessionsHelper

  layout 'admin/layouts/application'
  before_action :require_login

  private

  def require_login
    unless logged_in?
      flash[:danger] = "Please log in"
      redirect_to sign_in_path
    end
  end
end
