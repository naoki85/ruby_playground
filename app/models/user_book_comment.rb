class UserBookComment < ApplicationRecord
  belongs_to :user_book

  def self.all_group_by_date(options)
    user_book_comments = self.where(options)
    ret = {}
    user_book_comments.each do |user_book_comment|
      date = user_book_comment.date.strftime('%Y-%m-%d')
      ret[date] = [] unless ret.key?(date)
      ret[date] << user_book_comment
    end
    ret
  end
end
