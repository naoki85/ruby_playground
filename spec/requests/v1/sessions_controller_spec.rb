require 'rails_helper'

RSpec.describe V1::SessionsController, type: :request do
  describe '#create' do
    let(:request_url) { '/v1/login' }

    before do
      create(:user, email: 'hoge@example.com', password: 'hogehoge', password_confirmation: 'hogehoge')
    end

    it 'enable login' do
      post request_url, params: { email: 'hoge@example.com', password: 'hogehoge' }
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json['user']['authentication_token'].present?).to eq true
    end

    it 'disable login' do
      post request_url, params: { email: 'fuga@example.com', password: 'hogehoge' }
      expect(response.status).to eq 400
    end
  end
end
