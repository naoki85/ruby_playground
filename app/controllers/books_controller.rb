class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def search
  end

  def search_by_keyword
    @response = AmazonEcs.new.item_search(params[:keyword], {})
  end

  def show
    @book = Book.includes([user_book_comments: [:user]]).find(params[:id])
  end
end
