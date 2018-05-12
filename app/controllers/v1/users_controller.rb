module V1
  class UsersController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:show, :create]
    before_action :set_user, only: [:show]

    def show
    end

    def account
      @user = current_user
    end

    def create
      user = User.new(user_params)
      if user.save
        render :create, status: :ok
      else
        render_400
      end
    end

    def update
      @user = current_user
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end

    def set_user
      @user = User.includes([books: [:book_category]]).find(params[:id])
    end
  end
end