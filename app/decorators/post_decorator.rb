module PostDecorator

  # @return string
  def post_image_path(**options)
    if image_file_name.present?
      BookRecorder::Application.config.image_base_url + image_file_name
    else
      'https://s3-ap-northeast-1.amazonaws.com/bookrecorder-image/commons/default_user_icon.png'
    end
  end

  def summary
    content[0, 160].chomp
  end
end
