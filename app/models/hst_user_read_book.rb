class HstUserReadBook < ApplicationRecord
  belongs_to :user
  belongs_to :user_book

  def self.all_by_date(options)
    hst_user_read_books = self.where(options)
    ret = {}
    hst_user_read_books.each do |hst_user_read_book|
      date = hst_user_read_book.date.strftime('%Y-%m-%d')
      ret[date] = [] unless ret.key?(date)
      ret[date] << hst_user_read_book
    end
    ret
  end
end
