require 'rails_helper'

RSpec.describe AwsS3, type: :model do
  describe 'Resource' do
    subject { AwsS3::Resource.new }

    before do
      allow(subject).to receive(:upload).and_return(true)
    end

    it { expect(subject.upload('hogehoge', 'fugafuga')).to eq true }
  end
end
