json.partial! 'v1/shared/common'
json.set! :user_book_comments do
  json.array! @user_book_comments do |user_book_comment|
    json.id user_book_comment.id
    json.page user_book_comment.page
    json.comment user_book_comment.comment
    json.created_at user_book_comment.created_at.strftime('%Y-%m-%d')
    json.user do
      json.extract! user_book_comment.user, :id, :name, :avatar_image_path
    end
    json.book do
      json.extract! user_book_comment.book, :id, :title, :image_url, :detail_page_url
    end
  end
end
