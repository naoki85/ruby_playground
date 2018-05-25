require 'rails_helper'

RSpec.describe V1::BooksController, type: :request do
  describe '#index' do
    let(:request_url) { '/v1/books' }
    let(:publisher) { create(:publisher) }

    before do
      3.times do
        create(:book, publisher: publisher)
      end
      create_list(:book, 8)
    end

    it 'get book data' do
      get request_url
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['books'].size).to eq 10
    end

    it 'request with get params should return book data' do
      get request_url, params: { mode: 'recent', limit: 11 }
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['books'].size).to eq 11

      get request_url, params: { publisher_id: publisher.id }
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['books'].size).to eq 3

      get request_url, params: { limit: 11, offset: 8 }
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['books'].size).to eq 3
    end

    it 'request with invalid params should return no book' do
      get request_url, params: { limit: 'hoge' }
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['books'].size).to eq 0
    end
  end

  describe '#show' do
    let(:request_url) { '/v1/books/' }
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    before do
      3.times do
        create(:user_book_comment, user_id: user.id, book_id: book.id)
      end
    end

    it 'get book data' do
      get request_url + book.id.to_s
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['book']['id']).to eq book.id
      expect(json['book']['user_book_comments'].size).to eq 3
    end

    it 'when user is not found return 404 error' do
      get request_url + (book.id + 1).to_s
      expect(response.status).to eq 404
    end
  end

  describe '#search' do
    let(:request_url) { '/v1/books/search' }

    include_context 'user_authenticated'

    before do
      create(:book, title: 'テストA', author: '鈴木')
      create(:book, title: 'テストB', author: '田中')
      create(:book, title: 'テストC', author: '佐藤')
    end

    it 'should get books' do
      get request_url, params: { keyword: 'テスト' }, headers: { 'Authorization' => 'aaaaaaa' }
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['books'].size).to eq 3

      get request_url, params: { keyword: 'テストA' }, headers: { 'Authorization' => 'aaaaaaa' }
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['books'].size).to eq 1

      get request_url, params: { keyword: '鈴木' }, headers: { 'Authorization' => 'aaaaaaa' }
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['books'].size).to eq 1
    end

    it 'with no params should get error' do
      get request_url
      expect(response.status).to eq 401
    end
  end
end
