module V1
  class BooksController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:show]

    def show
      set_book
    end

    private

    def set_book
      @book = Book.includes([:book_category, user_book_comments: [:user]]).find(params[:id])
    end
  end
end