module V1
  class SessionsController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!

    def create
      @user = User.find_for_database_authentication(email: params[:email])
      return render_400 unless @user

      if @user.valid_password?(params[:password])
        sign_in :user, @user
        render :create, status: :ok
      else
        render_400
      end
    end
  end
end