module V1
  class UsersController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:show, :create, :summary]
    before_action :set_user, only: [:show]

    def show
    end

    def me
    end

    def create
      user = User.new(user_params)
      if user.save
        render :create, status: :ok
      else
        render_400
      end
    end

    def update
      @user = current_user
    end

    def summary
      user = User.find(params[:id])
      render_400 unless user
      start_date = Time.current.ago(6.days).beginning_of_day
      end_date = Time.current.end_of_day
      user_book_comments = UserBookComment.where(user_id: user.id).
          where('created_at >= ?', start_date).where('created_at <= ?', end_date).order('created_at ASC')
      start_date = Date.new(start_date.year, start_date.month, start_date.day)
      end_date = Date.new(end_date.year, end_date.month, end_date.day)
      @date_array = []
      (start_date..end_date).each do |date|
        @date_array << date.strftime('%Y-%m-%d')
      end

      ret_hash = {}
      @page_by_date_array = []
      user_book_comments.each do |user_book_comment|
        date = user_book_comment.created_at.strftime('%Y-%m-%d')
        ret_hash[date] = 0 unless ret_hash.key?(date)
        ret_hash[date] = ret_hash[date] + user_book_comment.page
      end
      @date_array.each do |date|
        page = ret_hash.key?(date) ? ret_hash[date] : 0
        @page_by_date_array << page
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end

    def set_user
      @user = User.includes([books: [:book_category]]).find(params[:id])
    end
  end
end