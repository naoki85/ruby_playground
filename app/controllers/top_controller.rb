class TopController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if user_signed_in?
      book_ids = UserBook.all.pluck(:book_id)
      book_categories = BookCategory.all
      books_by_category_id = Book.where(id: book_ids).group('book_category_id').count
      @book_by_category = {}
      book_categories.each do |book_category|
        # Unspecified の場合は next
        next if book_category.id == 0
        @book_by_category[book_category.name] = 0
        if books_by_category_id.key?(book_category.id)
          @book_by_category[book_category.name] = books_by_category_id[book_category.id]
        end
      end
    else
      @publishers = Publisher.all
      @books = Book.union_select_recent_each_publisher(@publishers.pluck(:id)).group_by(&:publisher_id)
    end
  end

  def user_policy
    # ビューファイルでlocale出し分け
  end

  def privacy_policy
    # ビューファイルでlocale出し分け
  end
end
