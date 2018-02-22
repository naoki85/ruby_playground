class UserBook < ApplicationRecord

  belongs_to :user
  belongs_to :book
  has_many :user_book_comments
end
