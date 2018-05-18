module V1
  class PublishersController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index, :show]

    def index
      @publishers = Publisher.active
      @books = Book.union_select_recent_each_publisher(@publishers.pluck(:id)).
          group_by(&:publisher_id)
    end

    def show
      @publisher = Publisher.includes([books: [:book_category]]).where(id: params[:id]).active.first
      render_404 unless @publisher
    end
  end
end