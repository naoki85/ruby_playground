FactoryBot.define do
  factory :post do
    association :user
    title 'test'
    content 'test'
    active 1
    published_at '2018-05-11'
  end
end
