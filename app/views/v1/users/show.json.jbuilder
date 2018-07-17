json.partial! 'v1/shared/common'
json.set! :user do
  json.id @user.id
  json.name @user.name
  json.avatar_image_path @user.avatar_image_path(resize: '200x200')
end
