json.partial! 'v1/shared/common'
json.set! :results do
  json.array! @items do |item|
    json.title item[:title]
    json.asin item[:asin]
    json.author item[:author]
    json.publisher item[:publisher]
    json.small_image_url item[:small_image_url]
    json.detail_page_url item[:detail_page_url]
  end
end
