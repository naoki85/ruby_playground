module V1
  class UserBooksController < ApiApplicationController

    def destroy
      set_user_book
      @user_book.destroy!
    end

    private

    def set_user_book
      raise InvalidParameter unless params[:book_id]
      @user_book = UserBook.where(book_id: params[:book_id], user_id: current_user.id).first
      raise InvalidParameter unless @user_book
    end
  end
end