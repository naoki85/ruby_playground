class UserBooksController < ApplicationController
  skip_before_action :authenticate_user!
  I18N_PREFIX = 'user_books_controller'

  def index
    @user_books = UserBook.includes([:book]).where(user_id: current_user.id)
  end

  def create
    if UserAddBookService.add(current_user.id, user_book_params)
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
        :asin, :title, :image_url, :detail_page_url, :publisher_name
    )
  end
end

