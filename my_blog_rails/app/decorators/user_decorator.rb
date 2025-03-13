module UserDecorator
  # @return boolean
  def avatar_image?
    image_url.present?
  end

  # @return string
  def avatar_image_path
    image_url.presence || 'https://s3-ap-northeast-1.amazonaws.com/bookrecorder-image/commons/default_user_icon.png'
  end

  def name
    username || 'No name'
  end
end
