class BooksController < ApplicationController

  def search
  end

  def search_by_keyword
    @response = AmazonEcs.new.item_search(params[:keyword], {})
  end

  def show
    @book = Book.includes([user_book_comments: [:user]]).find(params[:id])
  end
end
