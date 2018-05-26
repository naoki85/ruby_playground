json.partial! 'v1/shared/common'
json.set! :user_books do
  json.array! @user_books do |user_book|
    json.id user_book.id
    json.set! :book do
      json.id user_book.book.id
      json.title user_book.book.title
      json.image_url user_book.book.book_image_url
      json.detail_page_url user_book.book.detail_page_url
      json.book_category user_book.book.book_category.name
    end
  end
end
