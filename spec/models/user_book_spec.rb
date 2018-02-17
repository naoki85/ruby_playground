require 'rails_helper'

RSpec.describe UserBook, type: :model do
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
end
