FactoryBot.define do
  factory :recommended_book do
    association :post_category, factory: :post_category
    link 'https://sample.com'
    image_url 'https://sample.com'
    button_url 'https://sample.com'
    active 1
  end
end
