module V1
  class UserBooksController < ApiApplicationController

    def create
      if UserAddBookService.add(current_user.id, user_book_params)
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
      @user_book = UserBook.where(book_id: params[:book_id], user_id: current_user.id).first
      raise InvalidParameter unless @user_book
    end

    def user_book_params
      {
          title: params['user_book']['title'],
          asin: params['user_book']['asin'],
          author: params['user_book']['author'],
          publisher_name: params['user_book']['publisher'],
          image_url: params['user_book']['small_image_url'],
          detail_page_url: params['user_book']['detail_page_url']
      }
    end
  end
end