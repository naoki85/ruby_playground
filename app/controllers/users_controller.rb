class UsersController < ApplicationController

  def show
    # TODO: メタタグの生成に関わるから、user情報はサーバー側に持たせる？
    @user = User.select(:username).find(params[:id])
  end
end
