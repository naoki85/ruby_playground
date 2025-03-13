class Post < ApplicationRecord
  belongs_to :user
  belongs_to :post_category

  enum active: { draft: 0, published: 1 }
  attr_accessor :image

  validates :title,   presence: true, length: { maximum: 255 }

  scope :released, -> {
    where(active: 1).where('published_at <= ?', Time.zone.now)
  }

  def released?
    published? && published_at <= Time.zone.now
  end

  def save
    self.image_file_name = get_image_file_name if image.present?
    super
  end

  def update(attributes)
    self.image_file_name = get_image_file_name if image.present?
    super(attributes)
  end

  private

  def get_image_file_name
    upload_klass.upload(image.tempfile, image.original_filename, {})
  end

  def upload_klass
    @upload_klass ||= AwsS3::Resource.new
  end
end
