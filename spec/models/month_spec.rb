require 'rails_helper'

RSpec.describe Month, type: :model do
  subject { Month.new(Date.new(2018, 2, 17)) }
  describe '#days' do
    it 'should return days in February' do
      expect(subject.days.count).to eq 28
    end
  end
end
