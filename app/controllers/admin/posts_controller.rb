class Admin::PostsController < Admin::ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.includes([:post_category]).
        order('id DESC').page(params[:page]).per(10)
  end

  def show
  end

  def new
    @post = Post.new
    set_post_categories
  end

  def edit
    set_post_categories
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save && @post.attach_image(post_params)
      flash[:success] = '記事の登録が完了しました！'
      redirect_to admin_posts_url
    else
      set_post_categories
      render :new
    end
  end

  def update
    if @post.update(post_params) && @post.attach_image(post_params)
      flash[:success] = '記事の更新が完了しました！'
      redirect_to admin_posts_url
    else
      set_post_categories
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '記事の削除が完了しました！'
    redirect_to admin_posts_url
  end

  private

  def set_post
    @post = Post.includes([:post_category]).where(id: params[:id], user_id: current_user.id).first
    raise InvalidParameter unless @post
  end

  def set_post_categories
    @post_categories = PostCategory.all
  end

  def post_params
    params.require(:post).permit(:post_category_id,
                                 :title,
                                 :content,
                                 :active,
                                 :image,
                                 :published_at)
  end
end
