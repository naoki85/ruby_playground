module V1
  class PostsController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index, :show, :upload, :ogp]
    before_action :set_post, only: [:update, :destroy]

    def index
      @posts = Post.includes([:post_category]).select([:id, :post_category_id, :user_id, :title, :published_at, :image_file_name]).
          released.order('published_at DESC').page(params[:page])
    end

    def show
      @post = Post.includes([:post_category]).where(id: params[:id])
      if !params['preview']
        @post = @post.released
      end
      @post = @post.first
      if @post
        @recommended_books = RecommendedBook.get_four(@post.post_category_id)
        Rails.logger.info @recommended_books.size
      else
        render_404
      end
    end

    def upload
      file = params[:file]
      s3_resoirce = AwsS3::Resource.new
      upload_file_name = s3_resoirce.upload(file.tempfile, file.original_filename)
      if upload_file_name
        @image_url = "http://d29xhtkvbwm2ne.cloudfront.net/posts/#{upload_file_name}"
        render :upload
      else
        render_400
      end
    end

    def ogp
      url = URI.encode(CGI.unescape(params[:url]))
      @ogp_params = OgpParser.parse(url)
    end

    private

    def set_post
      @post = Post.where(id: params[:id], user_id: @user.id).first
      raise InvalidParameter unless @post
    end
  end
end