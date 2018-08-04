class RssController < ApplicationController
  layout false

  def index
    @posts = Post.released.order('published_at DESC').limit(10)
  end
end
