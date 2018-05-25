module V1
  class UserBooksController < ApiApplicationController

    def create
      user_book = UserBook.find_or_initialize_by(user_id: @user.id, book_id: user_book_params[:book_id])
      if user_book.new_record? && user_book.save
        render :create
      else
        render_400
      end
    end

    def destroy
      set_user_book
      @user_book.destroy!
    end

    private

    def set_user_book
      raise InvalidParameter unless params[:book_id]
      @user_book = UserBook.where(book_id: params[:book_id], user_id: @user.id).first
      raise InvalidParameter unless @user_book
    end

    def user_book_params
      params.require(:user_book).permit(:book_id)
    end
  end
end