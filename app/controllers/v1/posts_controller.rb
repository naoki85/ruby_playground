module V1
  class PostsController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:index, :show, :upload, :ogp]
    before_action :set_post, only: [:update, :destroy]

    def index
      @posts = Post.includes([:post_category]).select([:id, :post_category_id, :user_id, :title, :published_at]).
          released.order('published_at DESC').page(params[:page])
    end

    def show
      @post = Post.includes([:post_category]).where(id: params[:id])
      if !params['preview']
        @post = @post.released
      end
      @post = @post.first
      render_404 unless @post
    end

    def create
      post = @user.posts.build(post_params)
      if post.save && post.attach_image(params)
        render :create
      else
        render_400
      end
    end

    def update
      if @post.update(post_params) && @post.attach_image(params)
        render :update
      else
        render_400
      end
    end

    def destroy
      @post.destroy!
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
      url = CGI.unescape(params[:url])
      html = read_html(url)
      @title = if html.at('//meta[@property="og:title"]/@content')
                 html.at('//meta[@property="og:title"]/@content').value
               else
                 ''
               end
      @description = if html.at('//meta[@property="og:description"]/@content')
                       html.at('//meta[@property="og:description"]/@content').value
                     else
                       ''
                     end
      @image_url = if html.at('//meta[@property="og:image"]/@content')
                     html.at('//meta[@property="og:image"]/@content').value
                   else
                     ''
                   end
      @link = if html.at('//meta[@property="og:url"]/@content')
                html.at('//meta[@property="og:url"]/@content').value
              else
                url
              end
    end

    private

    def set_post
      @post = Post.where(id: params[:id], user_id: @user.id).first
      raise InvalidParameter unless @post
    end

    def post_params
      {
          title: params['title'],
          content: params['content'],
          active: params['active'].to_i,
          published_at: params['published_at']
      }
    end

    def read_html(url)
      user_agent = {"User-Agent" => "BookRecorder Bot"}
      charset = nil
      html = open(url, user_agent) do |f|
        charset = f.charset
        f.read
      end
      Nokogiri::HTML.parse(html, nil, charset)
    rescue StandardError => e
      p "Error: #{e}"
    end
  end
end