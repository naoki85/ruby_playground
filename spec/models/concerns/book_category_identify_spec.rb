require 'rails_helper'

RSpec.describe BookCategoryIdentifier, type: :model do
  subject { BookCategoryIdentifier }
  describe '#identify' do
    it { expect(subject.identify('ruby')).to eq 'Ruby' }
    it { expect(subject.identify('Ruby')).to eq 'Ruby' }
    it { expect(subject.identify('aaaaa')).to eq 'Unspecified' }
  end
end
