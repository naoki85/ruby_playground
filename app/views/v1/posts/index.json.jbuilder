json.partial! 'v1/shared/common'
json.set! :posts do
  json.array! @posts do |post|
    json.id post.id
    json.user_id post.user_id
    json.title post.title
    json.summary post.summary
    json.published_at post.published_at.strftime('%Y-%m-%d')
  end
end
