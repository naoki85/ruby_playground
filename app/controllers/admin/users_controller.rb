module Admin
  class UsersController < ApplicationController
    before_action :set_user

    def show
    end

    def edit
    end

    def update
      if @user.update_with_image(user_params)
        flash[:success] = t('messages.updated')
        redirect_to admin_me_path
      else
        flash[:error] = t('messages.updated')
        render :edit
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :new_password, :username, :image)
    end

    def set_user
      @user = User.find(current_user.id)
    end
  end
end