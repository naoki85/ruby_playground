module V1
  class SessionsController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!

    def create
      @user = User.find_by_email_and_password(params[:email], params[:password])
      return render_400 unless @user

      if @user.update_authentication_token!
        render :create, status: :ok
      else
        render_500
      end
    end

    def destroy
      authentication_token = request.headers['Authorization']
      user = User.find_by_active_token(authentication_token)
      return render_404 unless user

      user.reset_authentication_token!
      render :destroy
    end
  end
end