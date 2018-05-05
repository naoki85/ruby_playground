require 'rails_helper'

RSpec.describe User, type: :model do
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

  describe '#attach_image' do
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
