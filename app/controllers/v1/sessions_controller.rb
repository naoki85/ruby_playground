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

      if authentication_token
        unless authentication_token.include?(':')
          authenticate_error
          return
        end

        user_id = authentication_token.split(':').first
        user = User.where(id: user_id).first

        # if user && Devise.secure_compare(user.authentication_token, authentication_token)
        #   reset_session
        #   render :destroy
        #   return
        # end
      end
      authenticate_error
    end
  end
end