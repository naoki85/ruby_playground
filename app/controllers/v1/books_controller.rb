module V1
  class BooksController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index, :show]

    def index
      @books = Book.includes([:book_category])
      if params['mode'].present? && params['mode'] == 'recent'
        @books = @books.order('updated_at DESC')
      end
      if params['limit'].present?
        @books = @books.limit(params['limit'].to_i)
      else
        @books = @books.limit(10)
      end
    end

    def show
      set_book
    end

    def search
      response = AmazonEcs.new.item_search(params[:keyword], {})
      @items = get_items_from_response(response)
    end

    private

    def set_book
      @book = Book.includes([:book_category, user_book_comments: [:user]]).find(params[:id])
    end

    def get_items_from_response(response)
      items = []
      return items if response.nil?
      response.items.each do |item|
        item_attributes = item.get_element('ItemAttributes')
        hash_item = {
            title: item_attributes.get('Title'),
            asin: item.get('ASIN'),
            author: item_attributes.get('Author'),
            publisher: item_attributes.get('Publisher'),
            small_image_url: item.get_hash('MediumImage')['URL'],
            detail_page_url: item.get('DetailPageURL')
        }
        items << hash_item
      end
      items
    end
  end
end