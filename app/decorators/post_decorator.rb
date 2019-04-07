module PostDecorator

  # @return string
  def post_image_path(**options)
    Rails.cache.fetch("posts/#{self.id}/image_path", expired_in: 1.days) do
      if image_file_name.present?
        BookRecorder::Application.config.image_base_url + image_file_name
      else
        'https://s3-ap-northeast-1.amazonaws.com/bookrecorder-image/commons/default_user_icon.png'
      end
    end
  end

  def summary
    content[0, 160].chomp
  end
end
