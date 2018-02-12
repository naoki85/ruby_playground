class TopController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @user_books = UserBook.order('id desc').limit(10)
  end

  def search_books

  end

  def search_books_by_keyword
    @response = AmazonEcs.new.item_search(params[:keyword], {})
  end
end
