class Post < ApplicationRecord
  belongs_to :user
  belongs_to :post_category

  enum active: { draft: 0, published: 1 }
  attr_accessor :image

  validates :title,   presence: true, length: { maximum: 255 }

  scope :released, -> {
    where(active: 1).where('published_at <= ?', Time.zone.now)
  }

  after_update -> {
    Rails.cache.delete("posts/#{self.id}")
    Rails.cache.delete("posts/#{self.id}/image_path")
  }

  def released?
    published? && published_at <= Time.zone.now
  end

  def save
    if image.present?
      self.image_file_name = get_image_file_name
    end
    super
  end

  def update(attributes)
    if image.present?
      self.image_file_name = get_image_file_name
    end
    super(attributes)
  end

  # @param [Integer] id
  # @return [Post]
  def self.find(id)
    Rails.cache.fetch("posts/#{id}", expired_in: 1.days) do
      super(id)
    end
  end

  private

  def get_image_file_name
    upload_klass.upload(image.tempfile, image.original_filename, {})
  end

  def upload_klass
    @upload_klass ||= AwsS3::Resource.new
  end
end
