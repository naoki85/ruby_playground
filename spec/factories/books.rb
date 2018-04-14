FactoryBot.define do
  factory :book do
    association :book_category
    association :publisher
    asin '11111111'
    title 'test'
    image_url 'https://google.com'
    detail_page_url 'https://google.com'
  end
end
