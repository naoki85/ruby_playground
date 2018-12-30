require 'rails_helper'

RSpec.describe RecommendedBook, type: :model do
  describe '.get_four' do
    let(:post_category) { create(:post_category) }

    before do
      alt_post_category = create(:post_category, id: post_category.id + 1)
      4.times do
        create(:recommended_book, post_category_id: post_category.id, link: '111')
      end
      2.times do
        create(:recommended_book, post_category_id: alt_post_category.id, link: '222')
      end
    end

    it do
      r_books = RecommendedBook.get_four(post_category.id)
      expect(r_books.size).to eq 4
      r_books.each do |r_book|
        expect(r_book.link).to eq '111'
      end

      r_books = RecommendedBook.get_four(post_category.id + 1)
      expect(r_books.size).to eq 4
    end
  end
end
