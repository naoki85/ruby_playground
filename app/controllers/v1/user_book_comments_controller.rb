module V1
  class UserBookCommentsController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index]
    before_action :set_user_book_comment, only: [:update, :destroy]

    def index
      @user_book_comments = UserBookComment.includes([:book, :user]).order('created_at desc').limit(10)
    end

    def create
      book = Book.find(params[:book_id])
      @user_book_comment = @user.user_book_comments.new
      @user_book_comment.book_id = book.id
      @user_book_comment.page = params[:page]
      @user_book_comment.comment = params[:comment]

      if @user_book_comment.save
        render :create
      else
        render_400
      end
    end

    def update
      @user_book_comment.page = params[:page]
      @user_book_comment.comment = params[:comment]
      if @user_book_comment.save
        render :update
      else
        render_400
      end
    end

    def destroy
      @user_book_comment.destroy!
      render :destroy
    end

    private

    def set_user_book_comment
      @user_book_comment = UserBookComment.where(id: params[:id], user_id: @user.id).first
      raise InvalidParameter unless @user_book_comment
    end
  end
end