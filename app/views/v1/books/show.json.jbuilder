json.partial! 'v1/shared/common'
json.set! :book do
  json.id @book.id
  json.title @book.title
  json.image_url @book.book_image_url
  json.detail_page_url @book.detail_page_url
  json.book_category @book.book_category.name
end
