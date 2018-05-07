require 'rails_helper'

RSpec.describe ApiApplicationController, type: :request do
  describe '#authenticate_user_from_token!' do
    let(:request_url) { '/v1/user_books' }
    let(:user) { create(:user) }
    let(:user_book) { create(:user_book, user_id: user.id) }

    before do
      user_id = user.id
      token = 'aaaaaaa'
      user.authentication_token = user_id.to_s + ':' + token
      user.save!
    end

    it 'normal' do
      delete request_url, params: { book_id: user_book.id },
             headers: { 'Authorization' => user.id.to_s + ':aaaaaaa' }
      expect(response.status).to eq 200
    end

    it 'when no Authorization header return 401' do
      delete request_url, params: { book_id: user_book.id },
             headers: {}
      expect(response.status).to eq 401
    end

    it 'when mistake token in Authorization header return 401' do
      delete request_url, params: { book_id: user_book.id },
             headers: { 'Authorization' => user.id.to_s + ':bbbbbb' }
      expect(response.status).to eq 401
    end

    it 'when different user id in Authorization header return 401' do
      delete request_url, params: { book_id: user_book.id },
             headers: { 'Authorization' => (user.id + 1).to_s + ':aaaaaaa' }
      expect(response.status).to eq 401
    end
  end
end
