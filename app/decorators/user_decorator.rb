module UserDecorator

  # @return boolean
  def avatar_image?
    image.attached? || image_url.present?
  end

  # @return string
  def avatar_image_path
    return '' unless avatar_image?
    if image.attached?
      image
    elsif image_url.present?
      image_url
    else
      ''
    end
  end
end
