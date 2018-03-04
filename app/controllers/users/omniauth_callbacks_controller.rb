class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    user = User.find_or_initialize_by(provider: request.env['omniauth.auth'].provider, uid: request.env['omniauth.auth'].uid)
    if user.new_record?
      user.email = if request.env['omniauth.auth'].info.email.present?
                     request.env['omniauth.auth'].info.email
                   else
                     "#{request.env['omniauth.auth'].uid}-#{request.env['omniauth.auth'].provider}@example.com"
                   end
      user.password = Devise.friendly_token[0, 20]
      user.username = request.env['omniauth.auth'].info.nickname
      user.image_url = request.env['omniauth.auth'].info.image
      user.save!
    end
    flash[:notice] = I18n.t('devise.sessions.signed_in')
    sign_in_and_redirect user, event: :authentication
  end
end