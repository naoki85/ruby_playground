class Book < ApplicationRecord

  has_many :user_books, dependent: :destroy
  has_many :users, through: :user_books
  belongs_to :publisher
  belongs_to :book_category

  validates :asin,            length: { maximum: 255 }
  validates :title,           length: { maximum: 255 }
  validates :image_url,       length: { maximum: 255 }
  validates :detail_page_url, length: { maximum: 1020 }

  def self.union_select_recent_each_publisher(publisher_ids)
    arr_sql = []
    publisher_ids.each do |publisher_id|
      tmp_sql = self.select('id, publisher_id, title, image_url, detail_page_url').
          where(publisher_id: publisher_id).
          limit(10).to_sql
      arr_sql.push(tmp_sql)
    end
    sql = arr_sql.join(') UNION ALL (').insert(0, '(').insert(-1, ')')
    self.find_by_sql(sql)
  end
end
