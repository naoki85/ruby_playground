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

  describe '.union_select_recent_each_publisher' do
    before do
      ['Kodansya', 'Shueisya'].each do |publisher_name|
        publisher = FactoryBot.create(:publisher, name: publisher_name)
        10.times { FactoryBot.create(:book, publisher: publisher) }
      end
    end

    let(:publisher_ids) { Publisher.all.pluck(:id) }
    subject { Book.union_select_recent_each_publisher(publisher_ids) }

    it { expect(subject.count).to eq 20 }
  end
end
