class Admin::RecommendedBooksController < Admin::ApplicationController
  before_action :set_recommended_book, only: %i[show edit update destroy]

  def index
    @recommended_books = RecommendedBook.page(params[:page]).per(10)
  end

  def show; end

  def new
    @recommended_book = RecommendedBook.new
    set_post_categories
  end

  def edit
    set_post_categories
  end

  def create
    @recommended_book = RecommendedBook.new(recommended_book_params)
    if @recommended_book.save
      flash[:success] = t('messages.created')
      redirect_to admin_recommended_books_path
    else
      render :new
    end
  end

  def update
    if @recommended_book.update(recommended_book_params)
      flash[:success] = t('messages.updated')
      redirect_to admin_recommended_books_path
    else
      render :edit
    end
  end

  def destroy
    @recommended_book.destroy
    flash[:success] = t('messages.deleted')
    redirect_to admin_recommended_books_path
  end

  private

  def set_recommended_book
    @recommended_book = RecommendedBook.find(params[:id])
  end

  def set_post_categories
    @post_categories = PostCategory.all
  end

  def recommended_book_params
    params.require(:recommended_book).permit(:post_category_id,
                                             :link, :image_url, :button_url, :active)
  end
end
