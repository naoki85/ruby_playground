module PostDecorator

  # @return string
  def post_image_path(**options)
    if image.attached?
      if options.present? && options.key?(:resize)
        url_for(image.variant(resize: options[:resize]))
      else
        url_for(image)
      end
    else
      'https://s3-ap-northeast-1.amazonaws.com/bookrecorder-image/commons/default_user_icon.png'
    end
  end
end
