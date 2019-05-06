class PostCategory < ApplicationRecord
  has_many :posts

  validates :name,  length: { maximum: 64 }
  validates :color, length: { maximum: 8 }
end
