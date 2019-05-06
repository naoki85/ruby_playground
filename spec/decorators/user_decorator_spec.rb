require 'rails_helper'

describe UserDecorator do
  let(:user) { User.new.extend UserDecorator }
  subject { user }
  it { should be_a User }

  describe '#avatar_image?' do
    before { user.image_url = 'test' }
    it { expect(user.avatar_image?).to eq true }
  end

  describe '#avatar_image_path' do
    it do
      user.image_url = 'test'
      expect(user.avatar_image_path).to eq 'test'
      user.image_url = ''
      expect(user.avatar_image_path.present?).to eq true
    end
  end

  describe '#name' do
    it do
      user.username = 'test'
      expect(user.name).to eq 'test'
      user.username = nil
      expect(user.name).to eq 'No name'
    end
  end
end
