class UserBooksController < ApplicationController

  I18N_PREFIX = 'user_books_controller'

  def index
    @user_books = UserBook.where(user_id: current_user.id)
  end

  def create
    @user_book = current_user.user_books.build(user_book_params)

    if @user_book.save
      redirect_to user_books_path, notice: t("#{I18N_PREFIX}.notice.created")
    else
      redirect_to user_books_path, alert: t("#{I18N_PREFIX}.alert.not_created")
    end
  end

  def destroy
    set_user_book
    @user_book.destroy!
    redirect_to user_books_path, notice: t("#{I18N_PREFIX}.notice.deleted")
  end

  private

  def set_user_book
    @user_book = UserBook.where(id: params[:id], user_id: current_user.id).first
  end

  def user_book_params
    params.fetch(:user_book, {}).permit(
        :asin, :title, :image_url, :detail_page_url
    )
  end
end

