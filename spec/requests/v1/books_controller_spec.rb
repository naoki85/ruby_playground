require 'rails_helper'

RSpec.describe V1::BooksController, type: :request do
  describe '#index' do
    let(:request_url) { '/v1/books' }

    before do
      11.times do
        create(:book)
      end
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
end
