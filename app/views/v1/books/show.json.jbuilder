json.partial! 'v1/shared/common'
json.set! :book do
  json.id @book.id
  json.title @book.title
  json.image_url @book.book_image_url
  json.detail_page_url @book.detail_page_url
  json.book_category @book.book_category.name
  json.set! :user_book_comments do
    json.array! @book.user_book_comments do |user_book_comment|
      json.id user_book_comment.id
      json.page user_book_comment.page
      json.comment user_book_comment.comment
      json.created_at user_book_comment.created_at.strftime('%Y-%m-%d')
      json.user do
        json.id user_book_comment.user.id
        json.name user_book_comment.user.name
        json.avatar_image_path user_book_comment.user.avatar_image_path(resize: '200x200')
      end
    end
  end
end
