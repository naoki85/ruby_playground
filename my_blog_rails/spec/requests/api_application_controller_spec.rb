require 'rails_helper'

RSpec.describe ApiApplicationController, type: :request do
  describe '#authenticate_user_from_token!', skip: true do
    let(:request_url) { '/v1/me' }
    let(:user_book) { create(:user_book, user_id: user.id) }

    # include_context 'user_authenticated'

    it 'normal' do
      get request_url, headers: { 'Authorization' => 'aaaaaaa' }
      expect(response.status).to eq 200
    end

    it 'when no Authorization header return 401' do
      get request_url
      expect(response.status).to eq 401
    end

    it 'when mistake token in Authorization header return 401' do
      get request_url, headers: { 'Authorization' => 'bbbbbb' }
      expect(response.status).to eq 401
    end
  end

  describe 'health_check' do
    let(:request_url) { '/health_check' }
    it {
      get request_url
      expect(response.status).to eq 200
      expect(JSON.parse(response.body)['status']).to eq 200
    }
  end
end
