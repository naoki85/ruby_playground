FactoryBot.define do
  factory :user_book_comment do
    association :user
    association :book
  end
end
