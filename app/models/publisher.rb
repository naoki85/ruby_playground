class Publisher < ApplicationRecord

  has_many :books, dependent: :destroy

  scope :active, -> { where(active: 1) }

  validates :name, length: { maximum: 64 }
end
