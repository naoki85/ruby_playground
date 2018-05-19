json.partial! 'v1/shared/common'
json.set! :publishers do
  json.array! @publishers do |publisher|
    json.id publisher.id
    json.name publisher.name
    json.set! :books do
      json.array! @books[publisher.id] do |book|
        json.id book.id
        json.title book.title
        json.image_url book.image_url
        json.detail_page_url book.detail_page_url
        json.published_at book.published_at
      end
    end
  end
end
