require 'rails_helper'

RSpec.describe Crawler, type: :model do
  subject { Crawler }
  describe '.parse_date' do
    it do
      date_str_array = %w(発売日：2018/05/17 2018年5月17日発売)
      date_str_array.each do |str|
        expect(subject.parse_date(str)).to eq Date.new(2018,5,17)
      end
    end
  end
end
