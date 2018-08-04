module V1
  class BookCategoriesController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!

    def index
      @book_categories = BookCategory.where(pickup_flag: :pickup).limit(5)
    end
  end
end