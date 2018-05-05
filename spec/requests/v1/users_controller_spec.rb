require 'rails_helper'

RSpec.describe V1::UsersController, type: :request do
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

    context 'email is already registered' do
      before do
        create(:user, email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
      end

      it 'return error' do
        post request_url, params: { user: { email: 'test@example.com', password: 'testtest' } }
        expect(response.status).to eq 400
      end
    end
  end
end
