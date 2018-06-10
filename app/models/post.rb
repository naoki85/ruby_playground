class Post < ApplicationRecord
  belongs_to :user

  enum active: { draft: 0, published: 1 }

  validates :title,   presence: true, length: { maximum: 255 }
  validates :summary, presence: true, length: { maximum: 255 }

  scope :published, -> {
    where(active: 1).where('published_at <= ?', Time.zone.now)
  }

  def released?
    published? && published_at <= Time.zone.now
  end
end
