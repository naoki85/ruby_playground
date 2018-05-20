json.partial! 'v1/shared/common'
json.set! :user do
  json.id @user.id
  json.name @user.name
  json.avatar_image_path @user.avatar_image_path(resize: '200x200')
  json.set! :books do
    json.array! @user.books do |book|
      json.id book.id
      json.title book.title
      json.image_url book.book_image_url
      json.detail_page_url book.detail_page_url
      json.book_category book.book_category.name
    end
  end
end
