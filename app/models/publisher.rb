class Publisher < ApplicationRecord

  has_many :books, dependent: :destroy

  validates :name,            length: { maximum: 64 }
end
