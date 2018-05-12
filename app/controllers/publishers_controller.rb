class PublishersController < ApplicationController

  def show
    @publisher = Publisher.includes([:books]).find(params[:id])
    @books = Book.where(publisher_id: @publisher.id).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
  end
end
