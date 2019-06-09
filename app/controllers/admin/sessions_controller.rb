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
      redis = Redis.new(BookRecorder::Application.config.redis_config)
      key = Digest::SHA256.hexdigest(session_params[:email])
      failed_count = redis.get(key)
      failed_count = failed_count ? failed_count.to_i + 1 : 1
      redis.set(key, failed_count.to_s, ex: 900, nx: false, xx: false)
      redis.quit
      user = User.find_by(email: session_params[:email])
      if user&.locked?
        flash.now[:danger] = "Your account is locked. Please try in 1 hour"
      elsif user && failed_count.to_i >= 3
        user.locked_at = DateTime.now
        user.save
        flash.now[:danger] = "Your account is locked. Please try in 1 hour"
      else
        flash.now[:danger] = "Invalid email/password combination"
      end
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
    return unless logged_in?
    redirect_to admin_posts_path
    flash[:success] = "Already logged in"
  end
end
