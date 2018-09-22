class Admin::PostCategoriesController < Admin::ApplicationController
  before_action :set_post_category, only: [:edit, :update, :destroy]

  def index
    @post_categories = PostCategory.all
  end

  def new
    @post_category = PostCategory.new
  end

  def edit
  end

  def create
    @post_category = PostCategory.new(post_category_params)
    if @post_category.save
      flash[:success] = 'カテゴリーの登録が完了しました！'
      redirect_to admin_post_categories_url
    else
      render :new
    end
  end

  def update
    if @post_category.update(post_category_params)
      flash[:success] = 'カテゴリーの更新が完了しました！'
      redirect_to admin_post_categories_url
    else
      render :edit
    end
  end

  def destroy
    @post_category.destroy
    flash[:success] = 'カテゴリーの削除が完了しました！'
    redirect_to admin_post_categories_url
  end

  private

  def set_post_category
    @post_category = PostCategory.find(params[:id])
  end

  def post_category_params
    params.require(:post_category).permit(:name, :color)
  end
end
