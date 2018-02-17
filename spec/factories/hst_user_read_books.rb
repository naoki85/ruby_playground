FactoryBot.define do
  factory :hst_user_read_book do
    association :user, factory: :user
    association :user_book, factory: :user_book
  end
end
