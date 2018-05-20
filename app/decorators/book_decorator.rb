module BookDecorator

  # @return string
  def book_image_url
    if image_url.present?
      image_url
    else
      'https://s3-ap-northeast-1.amazonaws.com/bookrecorder-image/commons/default_user_icon.png'
    end
  end
end
