class BookCategory < ApplicationRecord

  has_many :books

  validates :name, length: { maximum: 64 }
end
