require 'rails_helper'

RSpec.describe UserBookComment, type: :model do
  describe '.all_group_by_date' do
    subject { UserBookComment.all_group_by_date({ user_book: user_book }) }
    let(:user_book) { create(:user_book) }
    before do
      create(:user_book_comment, user_book: user_book, date: '2018-02-01', comment: 'test1')
      create(:user_book_comment, user_book: user_book, date: '2018-02-10', comment: 'test2')
      create(:user_book_comment, user_book: user_book, date: '2018-02-20', comment: 'test3')
    end

    it 'dateがキーのハッシュが返る' do
      expect(subject.count).to eq 3
      expect(subject.key?('2018-02-01')).to eq true
      expect(subject.key?('2018-02-10')).to eq true
      expect(subject.key?('2018-02-20')).to eq true
    end
  end
end
