module Admin
  class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    before_action :set_user, only: [:show, :edit, :update]

    def show
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        flash[:success] = t('messages.created')
        redirect_to sign_in_path
      else
        flash[:error] = t('messages.created')
        render :new
      end
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
      params.require(:user).permit(:email, :password, :new_password, :username, :image)
    end

    def set_user
      @user = User.find(current_user.id)
    end
  end
end