class TopController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @publishers = Publisher.all
    @books = Book.union_select_recent_each_publisher(@publishers.pluck(:id)).group_by(&:publisher_id)
  end

  def user_policy
    # ビューファイルでlocale出し分け
  end

  def privacy_policy
    # ビューファイルでlocale出し分け
  end
end
