class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    render layout: 'ogp', status: :ok
  end

  def check_host_name
    if Rails.env.production? && request.host == 'admin.naoki85.me'
      render template: 'errors/error_404', status: :not_found, layout: false, content_type: 'text/html'
    end
  end
end
