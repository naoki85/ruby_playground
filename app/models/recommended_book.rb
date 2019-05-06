class RecommendedBook < ApplicationRecord
  belongs_to :post_category

  enum active: { draft: 0, published: 1 }

  after_update -> {
    Rails.cache.delete("recommended_books/#{self.post_category_id}")
  }

  # @param [Integer] post_category_id
  # @return [Array]
  def self.get_four(post_category_id)
    Rails.cache.fetch("recommended_books/#{post_category_id}", expired_in: 1.days) do
      r_books = get_by_category(post_category_id, 4)
      if r_books.size < 4
        limit = 4 - r_books.size
        additional_r_books = get_others(post_category_id, limit)
        r_books = r_books + additional_r_books
      end
      r_books
    end
  end

  private

  def self.get_by_category(category_id, limit)
    where(post_category_id: category_id).order('id DESC').limit(limit)
  end

  def self.get_others(category_id, limit)
    where("post_category_id != ?", category_id).order('id DESC').limit(limit)
  end
end
