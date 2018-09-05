class Post < ApplicationRecord
  belongs_to :user
  belongs_to :post_category

  enum active: { draft: 0, published: 1 }

  validates :title,   presence: true, length: { maximum: 255 }

  scope :released, -> {
    where(active: 1).where('published_at <= ?', Time.zone.now)
  }

  has_one_attached :image

  after_update -> {
    Rails.cache.delete("posts/#{self.id}")
    Rails.cache.delete("posts/#{self.id}/image_path")
  }

  def released?
    published? && published_at <= Time.zone.now
  end

  # @param [Hash] { image: 'test_file' }
  # @return [Boolean] | ActiveStorage
  def attach_image(params)
    if params.key?(:image) && params[:image].present?
      logger.info params[:image]
      image.attach(params[:image])
      return true
    else
      return true
    end
  end

  # @param [Integer] id
  # @return [Post]
  def self.find(id)
    Rails.cache.fetch("posts/#{id}", expired_in: 1.days) do
      super(id)
    end
  end
end
