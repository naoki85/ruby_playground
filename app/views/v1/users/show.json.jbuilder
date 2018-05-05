json.partial! 'v1/shared/common'
json.set! :user do
  json.extract! @user, :authentication_token
end
