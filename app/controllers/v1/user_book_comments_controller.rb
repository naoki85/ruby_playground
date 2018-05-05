module V1
  class UserBookCommentsController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index]

    def index
      @user_book_comments = UserBookComment.includes([:book, :user]).order('created_at desc').limit(10)
    end
  end
end