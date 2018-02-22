class UserAddBookService < BaseService
  def self.add(user_id, params)
    book = Book.find_or_initialize_by(asin: params[:asin])
    if book.new_record?
      book.title = params[:title]
      book.image_url = params[:image_url]
      book.detail_page_url = params[:detail_page_url]
      book.save!
    end

    user_book = UserBook.find_or_initialize_by(user_id: user_id, book_id: book.id)
    if user_book.new_record?
      user_book.save!
      return true
    else
      return false
    end
  end
end