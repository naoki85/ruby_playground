class RecommendedBook < ApplicationRecord
  belongs_to :post_category

  enum active: { draft: 0, published: 1 }
end
