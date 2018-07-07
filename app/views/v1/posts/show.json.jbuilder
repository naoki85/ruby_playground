json.partial! 'v1/shared/common'
json.set! :post do
  json.id @post.id
  json.user_id @post.user_id
  json.title @post.title
  json.content @post.content
  json.active @post.active
  json.published_at @post.published_at.strftime('%Y-%m-%d')
  json.post_image_path @post.post_image_path(resize: '100x100')
end
