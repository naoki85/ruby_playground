require 'rails_helper'

RSpec.describe BookCategory, type: :model do
  describe 'validate' do
    context '#name' do
      it { should validate_length_of(:name).is_at_most(64) }
    end
  end

  describe '.update_pickups' do
    let(:pickup_category) { create(:book_category, pickup_flag: 0) }

    before do
      2.times do
        create(:book_category, pickup_flag: 1)
      end
    end

    it 'update pickup category to 1' do
      BookCategory.update_pickups(Array.new(1, pickup_category.id))
      BookCategory.all.each do |book_category|
        if book_category.id == pickup_category.id
          expect(book_category.pickup_flag).to eq 'pickup'
        else
          expect(book_category.pickup_flag).to eq 'not_pickup'
        end
      end
    end
  end
end
