class TopController < ApplicationController
  def index

  end

  def search_books

  end

  def search_books_by_keyword
    @response = AmazonEcs.new.item_search(params[:keyword], {})
  end
end
