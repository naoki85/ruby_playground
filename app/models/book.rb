class Book < ApplicationRecord

  has_many :user_books, dependent: :destroy
  has_many :users, through: :user_books

  validates :asin,            length: { maximum: 255 }
  validates :title,           length: { maximum: 255 }
  validates :image_url,       length: { maximum: 255 }
  validates :detail_page_url, length: { maximum: 1020 }
end
