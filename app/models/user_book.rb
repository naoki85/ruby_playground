class UserBook < ApplicationRecord

  belongs_to :user

  validates :asin,            length: { maximum: 255 }
  validates :title,           length: { maximum: 255 }
  validates :image_url,       length: { maximum: 255 }
  validates :detail_page_url, length: { maximum: 1020 }
end
