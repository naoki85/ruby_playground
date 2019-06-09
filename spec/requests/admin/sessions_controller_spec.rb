require 'rails_helper'

RSpec.describe Admin::SessionsController, type: :request do
  before do
    create(:user, email: "test@gmail.com", password: "hogehoge")
  end

  describe 'Login user' do
    context 'invalid login information' do
      let(:params) { { session: { email: "test@invalid", password: "hogehoge" } } }
      it 'render login form again' do
        post sign_in_path, params: params
        expect(response.body.include?('Login')).to eq true
      end
    end

    context 'valid login information' do
      let(:params) { { session: { email: "test@gmail.com", password: "hogehoge" } } }

      it 'redirect to home' do
        user = User.find_by(email: "test@gmail.com")
        user.locked_at = DateTime.now - 2.hour
        user.save

        post sign_in_path, params: params
        expect(response.status).to eq 302

        user.reload
        expect(user.locked_at).to eq nil
      end
    end

    context 'login user is locked' do
      before do
        user = User.find_by(email: "test@gmail.com")
        user.locked_at = DateTime.now - 5.minutes
        user.save
      end

      let(:params) { { session: { email: "test@gmail.com", password: "hogehoge" } } }

      it 'could not login and set word, "account lock" in session value' do
        post sign_in_path, params: params
        expect(response.body.include?('Your account is locked')).to eq true
      end
    end

    context 'already failed login twice times' do
      before do
        redis = Redis.new(BookRecorder::Application.config.redis_config)
        key = Digest::SHA256.hexdigest("test@gmail.com")
        redis.set(key, '2', ex: 60, nx: false, xx: false)
        redis.quit
      end

      after do
        redis = Redis.new(BookRecorder::Application.config.redis_config)
        key = Digest::SHA256.hexdigest("test@gmail.com")
        redis.del(key)
        redis.quit
      end

      let(:params) { { session: { email: "test@gmail.com", password: "hogehoge" } } }
      let(:incorrect_params) { { session: { email: "test@gmail.com", password: "fugafuga" } } }

      it 'should login' do
        post sign_in_path, params: params
        expect(response.status).to eq 302
      end

      it 'should not login' do
        post sign_in_path, params: incorrect_params
        expect(response.body.include?('Your account is locked')).to eq true
      end
    end
  end
end
