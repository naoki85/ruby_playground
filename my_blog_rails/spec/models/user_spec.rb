require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validation' do
    context 'email' do
      it do
        user = build(:user)
        %w[test@example.com].each do |test_mail|
          user.email = test_mail
          expect(user.valid?).to eq true
        end
        %w[testtest].each do |test_mail|
          user.email = test_mail
          expect(user.valid?).to eq false
        end
      end

      it 'email is already exist' do
        create(:user, email: 'test@example.com')
        user = build(:user, email: 'test@example.com')
        expect(user.valid?).to eq false
      end
    end

    context 'valid_password' do
      it do
        user = build(:user)
        user.password = 'hogehoge'
        expect(user.valid?).to eq true
        user.password = ''
        expect(user.valid?).to eq false
      end

      it 'should valid registed user is empty password' do
        user = create(:user, email: 'test@example.com')
        user.password = ''
        expect(user.valid?).to eq true
      end
    end
  end

  describe '#encrypt_password' do
    it do
      user = create(:user)
      expect(user.encrypted_password.present?).to eq true
    end
  end

  describe '#find_by_email_and_password' do
    it 'should find user' do
      create(:user, email: 'test@example.com', password: 'testtest')
      user = User.find_by_email_and_password('test@example.com', 'testtest')
      expect(user.present?).to eq true
    end

    it 'incorrect password' do
      create(:user, email: 'test@example.com', password: 'testtest')
      user = User.find_by_email_and_password('test@example.com', 'test')
      expect(user).to eq nil
    end

    it 'email or password is empty' do
      expect(User.find_by_email_and_password('', '')).to eq nil
    end

    context 'user is locked' do
      before do
        create(:user, email: 'test@example.com', password: 'testtest', locked_at: DateTime.now)
      end

      it 'got nil' do
        user = User.find_by_email_and_password('test@example.com', 'test')
        expect(user).to eq nil
      end
    end
  end

  describe '#find_by_active_token' do
    it 'should find user' do
      create(:user, email: 'test@example.com', password: 'testtest',
             authentication_token: 'aaaa', authentication_token_expired_at: DateTime.tomorrow)
      user = User.find_by_active_token('aaaa')
      expect(user.present?).to eq true
    end
  end

  describe 'update_authentication_token!' do
    let(:user) { create(:user, email: 'test@example.com', password: 'testtest') }

    it 'should update' do
      expect(user.authentication_token.present?).to eq false
      user.update_authentication_token!
      expect(user.authentication_token.present?).to eq true
      expect(user.authentication_token_expired_at > DateTime.now).to eq true
    end
  end

  describe 'reset_authentication_token!' do
    let(:user) do
      create(:user, email: 'test@example.com', password: 'testtest',
                    authentication_token: 'aaaa', authentication_token_expired_at: DateTime.tomorrow)
    end

    it 'should update' do
      expect(user.authentication_token.present?).to eq true
      user.reset_authentication_token!
      expect(user.authentication_token.present?).to eq false
      expect(user.authentication_token_expired_at.present?).to eq false
    end
  end

  let(:user) { create(:user) }

  describe '#from_social?' do
    context 'when provider and uid do\'nt exist' do
      it { expect(user.from_social?).to eq false }
    end

    context 'when provider or uid exist' do
      before do
        user.provider = 'twitter'
        user.uid = 'aaaaaa'
        user.save!
      end
      it { expect(user.from_social?).to eq true }
    end
  end

  describe 'update_with_image' do
    let(:test_image_url) { 'http://d29xhtkvbwm2ne.cloudfront.net/test.png' }
    before do
      allow(user).to receive(:get_image_url).and_return(test_image_url)
    end

    it 'should update user image' do
      params = { username: "Naoki", image: fixture_file_upload('test.png', 'image/png', true) }
      user.update_with_image(params)
      expect(User.find(user.id).image_url).to eq test_image_url
      expect(User.find(user.id).username).to eq "Naoki"
    end
  end

  describe 'locked?' do
    it 'should locked when it is locked within one hour' do
      user.locked_at = DateTime.now - 59.minutes
      expect(user.locked?).to be_truthy
    end

    it 'should locked when it is locked before one hour' do
      expect(user.locked?).to be_falsey
      user.locked_at = DateTime.now - 1.hour
      expect(user.locked?).to be_falsey
    end
  end
end
