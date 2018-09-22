class PostCategory < ApplicationRecord

  has_many :posts

  validates :name,  length: { maximum: 64 }
  validates :color, length: { maximum: 8 }

  def self.all
    Rails.cache.fetch("post_categories", expired_in: 1.days) do
      super
    end
  end
end
