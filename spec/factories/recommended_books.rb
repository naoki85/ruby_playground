FactoryBot.define do
  factory :recommended_book do
    post_category_id 1
    link 'https://sample.com'
    image_url 'https://sample.com'
    button_url 'https://sample.com'
    active 1
  end
end
