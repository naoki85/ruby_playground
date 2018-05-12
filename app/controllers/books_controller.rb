class BooksController < ApplicationController

  def show
    @book = Book.select(:title).find(params[:id])
  end
end
