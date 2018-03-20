require 'rails_helper'

RSpec.describe Crawler, type: :model do
  subject { Crawler.run }
  describe '.run' do
    it { expect(subject.count).to eq 24 }
  end
end
