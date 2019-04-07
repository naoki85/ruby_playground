json.partial! 'v1/shared/common'
json.total_page @posts.total_pages
json.set! :posts do
  json.array! @posts do |post|
    json.id post.id
    json.user_id post.user_id
    json.title post.title
    json.published_at post.published_at.strftime('%Y-%m-%d')
    json.post_image_path post.post_image_path
    json.post_category do |category|
      category.id post.post_category.id
      category.name post.post_category.name
      category.color post.post_category.color
    end
  end
end
