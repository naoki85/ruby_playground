class ApiApplicationController < ApplicationController
  before_action :authenticate_user_from_token!

  def authenticate_user_from_token!
    authentication_token = request.headers['Authorization']
    @user = User.find_by_active_token(authentication_token)
    return render_401 unless @user
  end
end
