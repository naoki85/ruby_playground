FactoryBot.define do
  factory :user_book do
    association :user, factory: :user
    association :book, factory: :book
  end
end
