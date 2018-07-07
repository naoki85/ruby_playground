require 'rails_helper'

describe PostDecorator do
  let(:post) { Post.new.extend PostDecorator }
  subject { post }
  it { should be_a Post }

  describe '#summary' do
    it do
      subject.content = 'a' * 300
      expect(subject.summary).to eq 'a' * 160
    end
  end
end
