class TopController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @user_book_comments = UserBookComment.includes([:book, :user]).order('created_at desc').limit(10)
  end

  def user_policy
    # ビューファイルでlocale出し分け
  end

  def privacy_policy
    # ビューファイルでlocale出し分け
  end
end
