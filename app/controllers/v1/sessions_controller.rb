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

    def destroy
      authentication_token = request.headers['Authorization']

      if authentication_token
        unless authentication_token.include?(':')
          authenticate_error
          return
        end

        user_id = authentication_token.split(':').first
        user = User.where(id: user_id).first

        if user && Devise.secure_compare(user.authentication_token, authentication_token)
          reset_session
          render :destroy
          return
        end
      end
      authenticate_error
    end
  end
end