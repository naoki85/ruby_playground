class PostsController < ApplicationController
  before_action :check_host

  def index
    posts = Post.select(:title).released.order('published_at DESC').limit(5)
    @description = posts.reduce('') {|description, post| description + post.title + ' ' }
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def check_host
    if Rails.env.production? && request.host == 'bookrecorder.net'
      redirect_url = request.original_url
      redirect_url = redirect_url.gsub(/bookrecorder.net/, 'blog.bookrecorder.net')
      redirect_to redirect_url
    end
  end
end
