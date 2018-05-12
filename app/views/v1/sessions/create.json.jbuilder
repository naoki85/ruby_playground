json.partial! 'v1/shared/common'
json.set! :user do
  json.extract! @user, :id, :authentication_token, :authentication_token_expired_at
end
