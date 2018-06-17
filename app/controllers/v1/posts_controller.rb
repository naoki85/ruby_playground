module V1
  class PostsController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index, :show]
    before_action :set_post, only: [:update, :destroy]

    def index
      @posts = Post.select([:id, :user_id, :title, :summary, :published_at]).released.
          order('published_at DESC').page(params[:page])
    end

    def show
      @post = Post.find(params[:id])
    end

    def create
      post = @user.posts.build(post_params)
      if post.save
        render :create
      else
        render_400
      end
    end

    def update
      if @post.update(post_params)
        render :update
      else
        render_400
      end
    end

    def destroy
      @post.destroy!
    end

    private

    def set_post
      @post = Post.where(id: params[:id], user_id: @user.id).first
      raise InvalidParameter unless @post
    end

    def post_params
      params.require(:post).permit(:title, :summary, :content, :active, :published_at)
    end
  end
end