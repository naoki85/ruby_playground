class ApiApplicationController < ApplicationController
  include SessionsHelper
  before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user_from_token!, only: [:health_check]
  before_action :require_login, except: [:health_check]

  def health_check
    render json: { status: 200 }
  end

  def authenticate_user_from_token!
    authentication_token = request.headers['Authorization']
    @user = User.find_by_active_token(authentication_token)
    return render_401 unless @user
  end

  protected

  def require_login
    Rails.logger.info logged_in?
    render_401 unless logged_in?
  end
end
