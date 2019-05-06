module V1
  class PostsController < ApiApplicationController
    skip_before_action :authenticate_user_from_token!

    def upload
      file = params[:file]
      s3_resoirce = AwsS3::Resource.new
      upload_file_name = s3_resoirce.upload(file.tempfile, file.original_filename, prefix: 'posts')
      if upload_file_name
        @image_url = "#{BookRecorder::Application.config.image_base_url}posts/#{upload_file_name}"
        render :upload
      else
        render_400
      end
    end

    def ogp
      url = URI.encode(CGI.unescape(params[:url]))
      @ogp_params = OgpParser.parse(url)
    end
  end
end
