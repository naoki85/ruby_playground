class HstUserReadBooksController < ApplicationController
  before_action :set_hst_user_read_book, only: [:edit, :update, :destroy]

  def index
    raise InvalidParameter unless valid_user_book_id?
    @hst_user_read_books = HstUserReadBook.
        all_by_date({user_id: current_user.id, user_book_id: params[:user_book_id]})
    @month = Month.days
  end

  def new
    raise InvalidParameter unless valid_user_book_id?
    @hst_user_read_book = HstUserReadBook.new
    @hst_user_read_book.user_book_id = params[:user_book_id]
  end

  def edit
  end

  def create
    @hst_user_read_book = current_user.hst_user_read_books.build(hst_user_read_book_params)

    if @hst_user_read_book.save
      redirect_to hst_user_read_books_path(user_book_id: @hst_user_read_book.user_book_id),
                  notice: 'HstUserReadBook was successfully created.'
    else
      render :new
    end
  end

  def update
    if @hst_user_read_book.update(hst_user_read_book_params)
      redirect_to hst_user_read_books_path(user_book_id: @hst_user_read_book.user_book_id),
                  notice: 'HstUserReadBook was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    user_book_id = @hst_user_read_book.user_book_id
    @hst_user_read_book.destroy!
    redirect_to hst_user_read_books_path(user_book_id: user_book_id), notice: 'HstUserReadBook was successfully deleted.'
  end

  private

  def set_hst_user_read_book
    @hst_user_read_book = HstUserReadBook.where(id: params[:id], user_id: current_user.id).first
  end

  def hst_user_read_book_params
    params.fetch(:hst_user_read_book, {}).permit(
        :user_book_id, :date, :comment
    )
  end

  def valid_user_book_id?
    return false unless params[:user_book_id].present?
    @user_book = UserBook.where(id: params[:user_book_id], user_id: current_user.id).first
    return false unless @user_book
    return true
  end
end

