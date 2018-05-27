require 'rails_helper'

RSpec.describe V1::UsersController, type: :request do

  describe '#create' do
    let(:request_url) { '/v1/users/' }

    context 'normal pattern' do
      it 'create user' do
        before_count = User.count
        post request_url, params: { user: { email: 'test@example.com', password: 'testtest' } }
        expect(response.status).to eq 200
        expect(User.count).to eq before_count + 1
      end
    end

    context 'not valid user' do
      before do
        create(:user, email: 'test@example.com', password: 'testtest')
      end

      it 'return error' do
        post request_url, params: { user: { email: 'test@example.com', password: 'testtest' } }
        expect(response.status).to eq 400
      end
    end
  end

  describe '#show' do
    let(:request_url) { '/v1/users/' }
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    before do
      create(:user_book, user_id: user.id, book_id: book.id)
    end

    it 'get user data' do
      get request_url + user.id.to_s
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['user']['id']).to eq user.id
      expect(json['user']['books'].size).to eq 1
    end

    it 'when user is not found return 404 error' do
      get request_url + (user.id + 1).to_s
      expect(response.status).to eq 404
    end
  end

  describe '#me' do
    let(:request_url) { '/v1/me' }
    include_context 'user_authenticated'

    context 'normal pattern' do
      it 'get user account' do
        get request_url, headers: { 'Authorization' => 'aaaaaaa' }
        expect(response.status).to eq 200
      end
    end
  end

  describe '#summary' do
    let(:request_url) { '/v1/users/summary' }
    let(:user) { create(:user) }

    before do
      10.times do
        create(:user_book_comment, user_id: user.id, page: 10)
      end
    end

    context 'normal pattern' do
      it 'get summary for line chart' do
        get request_url, params: { id: user.id }
        expect(response.status).to eq 200
        json = JSON.parse(response.body)
        expect(json['summary']['pages'].last).to eq 100
      end
    end
  end
end
