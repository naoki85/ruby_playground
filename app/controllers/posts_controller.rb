class PostsController < ApplicationController

  def index
    posts = Post.select(:title).released.order('published_at DESC').limit(5)
    @description = posts.reduce('') {|description, post| description + post.title + ' ' }
  end

  def show
    @post = Post.find(params[:id])
  end
end
