json.partial! 'v1/shared/common'
json.set! :user do
  json.id @user.id
  json.authentication_token @user.authentication_token
  json.authentication_token_expired_at @user.authentication_token_expired_at.strftime('%Y-%m-%d %H:%M:%S')
end
