class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @user = User.includes([:books]).find(params[:id])
  end
end
