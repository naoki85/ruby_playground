require 'rails_helper'

RSpec.describe V1::BooksController, type: :request, skip: true do
  describe '#index' do
    let(:request_url) { '/v1/books' }
    let(:publisher) { create(:publisher) }
    let(:book_category) { create(:book_category) }
    let(:inactive_publisher) { create(:publisher, active: 0) }

    before do
      3.times do
        create(:book, publisher: publisher)
      end
      create_list(:book, 8)
      create(:book, publisher: inactive_publisher)
      create(:book, book_category: book_category)
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
      expect(json['books'].size).to eq 4

      get request_url, params: { book_category_id: book_category.id }
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['books'].size).to eq 1
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

    it 'get book data' do
      get request_url + book.id.to_s
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['book']['id']).to eq book.id
    end

    it 'when user is not found return 404 error' do
      get request_url + (book.id + 1).to_s
      expect(response.status).to eq 404
    end

    it 'when publisher is not active return 404 error' do
      publisher = Publisher.find(book.publisher_id)
      publisher.active = 0
      publisher.save
      get request_url + book.id.to_s
      expect(response.status).to eq 404
    end
  end
end
