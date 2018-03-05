require 'rails_helper'

describe UserDecorator do
  let(:user) { User.new.extend UserDecorator }
  subject { user }
  it { should be_a User }

  describe '#avatar_image?' do
    before {user.image_url = 'test' }
    it { expect(user.avatar_image?).to eq true }
  end

  describe '#avatar_image_path', skip: true do
  end
end
