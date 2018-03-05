module UserDecorator

  # @return boolean
  def avatar_image?
    image.attached? || image_url.present?
  end

  # @return string
  def avatar_image_path(**options)
    return '' unless avatar_image?
    if image.attached?
      if options.present? && options.key?(:resize)
        image.variant(resize: options[:resize])
      else
        image
      end
    elsif image_url.present?
      image_url
    else
      ''
    end
  end
end
