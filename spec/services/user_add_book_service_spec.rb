require 'rails_helper'

RSpec.describe UserAddBookService, type: :service do
  describe '.add' do
    subject { UserAddBookService.add(user_id, params) }
    let(:user) { create(:user) }
    let(:user_id) { user.id }
    let(:params) do
      { publisher_name: '集英社', asin: '11111111', title: 'test', image_url: 'https://google.com', detail_page_url: 'https://google.com' }
    end
    before do
      create(:publisher, id: 0, name: 'No result')
      create(:book_category, id: 0, name: 'No result')
    end

    describe 'まだbookもuser_bookも登録されていない場合' do
      it 'bookとuser_bookが増えている' do
        expect(subject).to eq true
        expect(Book.all.count).to eq 1
        expect(UserBook.all.count).to eq 1
      end
    end

    describe 'bookがすでに登録済みの場合' do
      before { create(:book, asin: '11111111') }
      it 'user_bookが増えている' do
        expect(subject).to eq true
        expect(Book.all.count).to eq 1
        expect(UserBook.all.count).to eq 1
      end
    end

    describe 'book、user_bookがすでに登録済みの場合' do
      let(:book) { create(:book, asin: '11111111') }
      before { create(:user_book, user: user, book: book) }
      it 'falseが返る' do
        expect(subject).to eq false
        expect(Book.all.count).to eq 1
        expect(UserBook.all.count).to eq 1
      end
    end

    describe 'publisherがすでに存在する場合' do
      before { create(:publisher, name: '集英社') }
      it 'trueが返り、Publisher.countは変化しない' do
        before_count = Publisher.count
        expect(subject).to eq true
        expect(Publisher.count).to eq before_count
      end
    end

    describe 'publisherが存在しない場合' do
      it 'trueが返り、Publisher.countは1増える' do
        before_count = Publisher.count
        expect(subject).to eq true
        expect(Publisher.count).to eq before_count + 1
      end
    end
  end
end
