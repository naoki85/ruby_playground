class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    render layout: 'ogp', status: 302, location: "https://blog.naoki85.me/posts/#{@post.id}", content_type: 'text/html'
  end

  def check_host_name
    if Rails.env.production? && request.host == 'admin.naoki85.me'
      render template: 'errors/error_404', status: 404, layout: false, content_type: 'text/html'
    end
  end
end
