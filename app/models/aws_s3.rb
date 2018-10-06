require 'aws-sdk-s3'

class AwsS3

  class Resource
    def initialize
      @resource = Aws::S3::Resource.new(
          :region => 'ap-northeast-1',
          :access_key_id => ENV['S3_ACCESS_KEY_ID'],
          :secret_access_key => ENV['S3_SECRET_KEY']
      )
    end

    # @param [Tempfile] tempfile
    # @param [String] original_filename
    # @return [String]
    def upload(tempfile, original_filename)
      file_name = "#{Time.now.to_i}_#{original_filename}"
      s3_obj = @resource.bucket('bookrecorder-image').object("posts/#{file_name}")
      s3_obj.upload_file(tempfile)
      file_name
    rescue
      nil
    end
  end
end