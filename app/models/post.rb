class Post < ApplicationRecord
  belongs_to :user

  enum active: { draft: 0, published: 1 }

  validates :title,   presence: true, length: { maximum: 255 }
  validates :summary, presence: true, length: { maximum: 255 }

  scope :released, -> {
    where(active: 1).where('published_at <= ?', Time.zone.now)
  }

  has_one_attached :image

  def released?
    published? && published_at <= Time.zone.now
  end

  # @param hash { image: 'test_file' }
  # @return bool | ActiveStorage
  def attach_image(params)
    if params.key?(:image) && params[:image].present?
      logger.info params[:image]
      image.attach(params[:image])
      return true
    else
      return true
    end
  end
end
