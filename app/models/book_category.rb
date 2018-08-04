class BookCategory < ApplicationRecord

  has_many :books

  enum pickup_flag: { not_pickup: 0, pickup: 1 }

  validates :name, length: { maximum: 64 }

  # 引数の id の pickup_flag を 1 にして、それ以外を 0 にする
  # @param array ids
  def self.update_pickups(ids)
    self.all.each do |book_category|
      if ids.include?(book_category.id)
        book_category.pickup_flag = :pickup
      else
        book_category.pickup_flag = :not_pickup
      end
      if book_category.changed?
        book_category.save
      end
    end
  end
end
