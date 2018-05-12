json.partial! 'v1/shared/common'
json.set! :user do
  json.id @user.id
  json.name @user.name
  json.email @user.email
  json.avatar_image_path @user.avatar_image_path(resize: '100x100')
end
