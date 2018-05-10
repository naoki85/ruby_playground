class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def search
  end

  def show
    @book = Book.select(:title).find(params[:id])
  end
end
