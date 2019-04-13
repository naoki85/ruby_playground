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
    def upload(tempfile, original_filename, **options)
      file_name = "#{Time.now.to_i}_#{original_filename}"
      file_path = file_name
      if options[:prefix].present?
        file_path = "#{options[:prefix]}/#{file_name}"
      end

      s3_obj = @resource.bucket('bookrecorder-image').object(file_path)
      s3_obj.upload_file(tempfile)
      file_name
    rescue
      nil
    end
  end
end