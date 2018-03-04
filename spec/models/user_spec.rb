require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#from_social?' do
    let(:user) { create(:user) }
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
end
