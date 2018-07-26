json.partial! 'v1/shared/common'
json.set! :book_categories do
  json.array! @book_categories do |book_category|
    json.id book_category.id
    json.name book_category.name
  end
end
