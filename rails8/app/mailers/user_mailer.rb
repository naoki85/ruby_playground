class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url  = "http://example.com/login"
    mail(to: @user.email,
      subject: "私の素敵なサイトへようこそ",
      content_type: 'text/html'
    )
  end
end
