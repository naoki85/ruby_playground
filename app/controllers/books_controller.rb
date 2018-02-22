class BooksController < ApplicationController

  def search
  end

  def search_by_keyword
    @response = AmazonEcs.new.item_search(params[:keyword], {})
  end
end
