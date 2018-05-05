module UserDecorator

  # @return boolean
  def avatar_image?
    image.attached? || image_url.present?
  end

  # @return string
  def avatar_image_path(**options)
    if image.attached?
      if options.present? && options.key?(:resize)
        url_for(image.variant(resize: options[:resize]))
      else
        url_for(image)
      end
    elsif image_url.present?
      image_url
    else
      'commons/default_user_icon.png'
    end
  end

  def name
    if username.present?
      username
    else
      'No name'
    end
  end
end
