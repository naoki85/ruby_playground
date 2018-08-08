class Book < ApplicationRecord

  belongs_to :publisher
  belongs_to :book_category

  validates :asin,            length: { maximum: 255 }
  validates :title,           length: { maximum: 255 }
  validates :image_url,       length: { maximum: 255 }
  validates :detail_page_url, length: { maximum: 1020 }

  # book_category_id の多い順に 5件返却する
  # Comic が入ってしまうのでbook_category_idは1より大きくする
  # @return array
  def self.pickup_categories
    self.where('book_category_id > 1').group(:book_category_id).
        order('count_all DESC').limit(5).count.keys
  end
end
