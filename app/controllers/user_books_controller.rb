class UserBooksController < ApplicationController
  before_action :set_user_book, only: [:show, :edit, :update, :destroy]

  def index
    @user_books = UserBook.where(user_id: current_user.id)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @user_book = current_user.user_books.build(user_book_params)

    if @user_book.save
      redirect_to user_books_path, notice: 'Event was successfully created.'
    else
      redirect_to user_books_path, alert: 'Event was not created.'
    end
  end

  def update
    # respond_to do |format|
    #   if @event.update(event_params)
    #     format.html { redirect_to admin_event_path(@event), notice: 'Event was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @event }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @event.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    # @event.destroy!
    # redirect_to admin_events_path, notice: 'Event was deleted.'
  end

  private

  def set_user_book
    @user_book = UserBook.where(id: params[:id], user_id: current_user.id).first
  end

  def user_book_params
    params.fetch(:user_book, {}).permit(
        :asin, :title, :image_url
    )
  end
end

