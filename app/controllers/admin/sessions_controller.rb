class Admin::SessionsController < Admin::ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :logged_in_user_redirect, only: %i[new create]

  def new; end

  def create
    user = User.find_by_email_and_password(session_params[:email],
                                           session_params[:password])
    if user&.update_authentication_token!
      log_in user
      flash[:success] = "Login Successful"
      redirect_to admin_posts_path
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Have a nice day!!"
    redirect_to sign_in_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def logged_in_user_redirect
    if logged_in?
      redirect_to admin_posts_path
      flash[:success] = "Already logged in"
    end
  end
end
