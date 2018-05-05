module V1
  class UsersController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    def create
      @user = User.new(user_params)

      if @user.save!
        render :show, status: :ok
      else
        render :error, status: :error
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end