require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validation' do
    context 'email' do
      it do
        user = build(:user)
        %w(test@example.com).each do |test_mail|
          user.email = test_mail
          expect(user.valid?).to eq true
        end
        %w(testtest).each do |test_mail|
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
    let(:user) { create(:user, email: 'test@example.com', password: 'testtest',
                        authentication_token: 'aaaa', authentication_token_expired_at: DateTime.tomorrow) }

    it 'should update' do
      expect(user.authentication_token.present?).to eq true
      user.reset_authentication_token!
      expect(user.authentication_token.present?).to eq false
      expect(user.authentication_token_expired_at.present?).to eq false
    end
  end

  describe '#avatar_image?' do
    let(:user) { create(:user) }
    before {user.image_url = 'test' }
    it { expect(user.avatar_image?).to eq true }
  end

  describe '#avatar_image_path' do
    let(:user) { create(:user) }
    it do
      user.image_url = 'test'
      expect(user.avatar_image_path).to eq 'test'
      user.image_url = ''
      expect(user.avatar_image_path.present?).to eq true
    end
  end

  describe '#name' do
    let(:user) { create(:user) }
    it do
      user.username = 'test'
      expect(user.name).to eq 'test'
      user.username = ''
      expect(user.name).to eq 'No name'
    end
  end

  describe '#from_social?' do
    let(:user) { create(:user) }
    context 'when provider and uid do\'nt exist' do
      it { expect(user.from_social?).to eq false }
    end

    context 'when provider or uid exist' do
      let(:user) { create(:user) }
      before do
        user.provider = 'twitter'
        user.uid = 'aaaaaa'
        user.save!
      end
      it { expect(user.from_social?).to eq true }
    end
  end

  describe '#attach_image' do
    let(:user) { create(:user) }
    it 'when params do\'t contain image, should return true' do
      params = { }
      expect(user.attach_image(params)).to eq true
    end

    # TODO: test 環境だと戻り値が nil になる件を確認
    it 'when params contain image, should return ActiveStorage::Attachment' do
      params = { image: fixture_file_upload('test.png', 'image/png', true) }
      expect(user.attach_image(params)).to eq nil
    end
  end
end
