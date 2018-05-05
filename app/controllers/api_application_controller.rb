class ApiApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  before_action :authenticate_user_from_token!

  respond_to :json

  ##
  # User Authentication
  # Authenticates the user with OAuth2 Resource Owner Password Credentials
  def authenticate_user_from_token!
    authentication_token = request.headers['Authorization']

    if authentication_token
      authenticate_with_authentication_token authentication_token
    else
      authenticate_error
    end
  end

  private

  def authenticate_with_authentication_token(authentication_token)
    unless authentication_token.include?(':')
      authenticate_error
      return
    end

    user_id = authentication_token.split(':').first
    user = User.where(id: user_id).first

    if user && Devise.secure_compare(user.authentication_token, authentication_token)
      # User can access
      sign_in user, store: false
    else
      authenticate_error
    end
  end

  ##
  # Authentication Failure
  # Renders a 401 error
  def authenticate_error
    render json: { error: t('devise.failure.unauthenticated') }, status: 401
  end
end
