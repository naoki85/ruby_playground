json.partial! 'v1/shared/common'
json.set! :post do
  json.id @post.id
  json.user_id @post.user_id
  json.title @post.title
  json.content @post.content
  json.active @post.active
  json.published_at @post.published_at.strftime('%Y-%m-%d')
  json.post_image_path @post.post_image_path(resize: '100x100')
  json.post_category do |category|
    category.name @post.post_category.name
    category.color @post.post_category.color
  end
end
json.set! :recommended_books do
  json.array! @recommended_books do |recommended_book|
    json.url recommended_book.link
    json.image_url recommended_book.image_url
    json.button_url recommended_book.button_url
  end
end
