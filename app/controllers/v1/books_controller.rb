module V1
  class BooksController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index, :show]

    def index
      @books = Book.includes([:book_category])
      publisher_ids = Publisher.active.map { |publisher| publisher.id }
      if params['publisher_id'].present? && publisher_ids.include?(params['publisher_id'].to_i)
        @books = @books.where(publisher_id: params['publisher_id'])
      else
        @books = @books.where(publisher_id: publisher_ids)
      end
      if params['start_date'].present?
        @books = @books.where('published_at >= ?', params['start_date'])
      end
      if params['end_date'].present?
        @books = @books.where('published_at <= ?', params['end_date'])
      end
      if params['mode'].present? && params['mode'] == 'recent'
        @books = @books.order('updated_at DESC')
      end
      limit = params['limit'].present? ? params['limit'].to_i : 10
      offset = params['offset'].present? ? params['offset'].to_i : 0
      @books = @books.limit(limit).offset(offset)
    end

    def show
      set_book
    end

    def search
      render_401 unless params['keyword'].present?
      @books = Book.where('title LIKE ?', "%#{params['keyword']}%").
          or(Book.where('author LIKE ?', "%#{params['keyword']}%"))
    end

    private

    def set_book
      @book = Book.includes([:book_category]).find(params[:id])
      publisher_ids = Publisher.active.map { |publisher| publisher.id }
      render_404 unless publisher_ids.include?(@book.publisher_id)
    end
  end
end