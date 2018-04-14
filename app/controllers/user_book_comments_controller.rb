class UserBookCommentsController < ApplicationController
  before_action :set_user_book_comment, only: [:edit, :update, :destroy]

  I18N_PREFIX = 'user_book_comments_controller'

  def index
    raise InvalidParameter unless valid_user_book_id?
    @user_book_comments = UserBookComment.
        all_group_by_date({user_book_id: params[:user_book_id]})
    @month = Month.new.days
  end

  def new
    raise InvalidParameter unless valid_book_id?
    @user_book_comment = UserBookComment.new
    @user_book_comment.book_id = @book.id
  end

  def edit
  end

  def create
    @book = Book.find(user_book_comment_params[:book_id])
    redirect_to root_url, alert: t("#{I18N_PREFIX}.alert.not_permitted") unless @book
    @user_book_comment = current_user.user_book_comments.new(user_book_comment_params)

    if @user_book_comment.save
      redirect_to book_path(@user_book_comment.book_id),
                  notice: t("#{I18N_PREFIX}.notice.created")
    else
      render :new
    end
  end

  def update
    if @user_book_comment.update(user_book_comment_params)
      redirect_to book_path(@user_book_comment.book_id),
                  notice: t("#{I18N_PREFIX}.notice.updated")
    else
      render :edit
    end
  end

  def destroy
    book_id = @user_book_comment.book_id
    @user_book_comment.destroy!
    redirect_to book_path(book_id),
                notice: t("#{I18N_PREFIX}.notice.deleted")
  end

  private

  def set_user_book_comment
    @user_book_comment = UserBookComment.find(params[:id])
    unless @user_book_comment.user_id == current_user.id
      raise InvalidParameter
    end
  end

  def user_book_comment_params
    params.fetch(:user_book_comment, {}).permit(
        :book_id, :comment
    )
  end

  def valid_book_id?
    return false unless params[:book_id].present?
    @book = Book.find(params[:book_id])
    return false unless @book
    return true
  end
end

