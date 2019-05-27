module UserDecorator
  # @return boolean
  def avatar_image?
    image_url.present?
  end

  # @return string
  def avatar_image_path
    if image_url.present?
      image_url
    else
      'https://s3-ap-northeast-1.amazonaws.com/bookrecorder-image/commons/default_user_icon.png'
    end
  end

  def name
    username || 'No name'
  end
end
