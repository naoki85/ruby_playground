require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validate' do
    context '#asin' do
      it { should validate_length_of(:asin).is_at_most(255) }
    end
    context '#title' do
      it { should validate_length_of(:title).is_at_most(255) }
    end
    context '#image_url' do
      it { should validate_length_of(:image_url).is_at_most(255) }
    end
    context '#detail_page_url' do
      it { should validate_length_of(:detail_page_url).is_at_most(1020) }
    end
  end

  describe '.pickup_categories' do
    before do
      5.times do |i|
        create(:book_category, id: i + 1)
        (i + 1).times do
          create(:book, book_category_id: i + 1)
        end
      end
    end
    subject { Book.pickup_categories }

    it { expect(subject).to eq [5, 4, 3, 2, 1] }
  end
end
