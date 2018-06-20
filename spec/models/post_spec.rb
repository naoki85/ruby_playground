require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validate' do
    context '#title' do
      it { should validate_length_of(:title).is_at_most(255) }
    end
    context '#summary' do
      it { should validate_length_of(:title).is_at_most(255) }
    end
  end

  describe '#released?' do
    let(:post) { create(:post) }

    it do
      post.active = 1
      post.published_at = Time.zone.yesterday
      expect(post.released?).to eq true

      post.active = 0
      post.published_at = Time.zone.yesterday
      expect(post.released?).to eq false
    end
  end
end
