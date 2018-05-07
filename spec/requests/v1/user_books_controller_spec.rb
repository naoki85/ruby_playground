require 'rails_helper'

RSpec.describe V1::UserBooksController, type: :request do
  describe '#destroy' do
    let(:request_url) { '/v1/user_books' }
    let(:user) { create(:user) }
    let(:user_book) { create(:user_book, user_id: user.id) }

    before do
      user_id = user.id
      token = 'aaaaaaa'
      user.authentication_token = user_id.to_s + ':' + token
      user.save!
    end

    it 'delete a record has target id' do
      delete request_url, params: { book_id: user_book.id },
             headers: { 'Authorization' => user.id.to_s + ':aaaaaaa' }
      expect(response.status).to eq 200
      expect(UserBook.where(id: user_book.id).size).to eq 0
    end

    it 'when params don\'t contain book_id return 400' do
      delete request_url, params: { },
             headers: { 'Authorization' => user.id.to_s + ':aaaaaaa' }
      expect(response.status).to eq 400
    end

    it 'when user don\'t have target user_book return 400' do
      delete request_url, params: { book_id: user_book.id + 1 },
             headers: { 'Authorization' => user.id.to_s + ':aaaaaaa' }
      expect(response.status).to eq 400
    end
  end
end
