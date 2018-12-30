require 'rails_helper'

RSpec.describe RecommendedBook, type: :model do
  describe '.get_four' do
    let(:post_category_id) { 1 }

    before do
      4.times do
        create(:recommended_book, post_category_id: post_category_id, link: '111')
      end
      2.times do
        create(:recommended_book, post_category_id: post_category_id + 1, link: '222')
      end
    end

    it do
      r_books = RecommendedBook.get_four(post_category_id)
      expect(r_books.size).to eq 4
      r_books.each do |r_book|
        expect(r_book.link).to eq '111'
      end

      r_books = RecommendedBook.get_four(post_category_id + 1)
      expect(r_books.size).to eq 4
    end
  end
end
