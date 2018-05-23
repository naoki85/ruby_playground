module V1
  class PublishersController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index, :show]

    def index
      @publishers = Publisher.active.order('kana ASC')
    end

    def show
      @publisher = Publisher.where(id: params[:id]).active.first
      render_404 unless @publisher
    end
  end
end