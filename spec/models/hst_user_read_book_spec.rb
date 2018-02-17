require 'rails_helper'

RSpec.describe HstUserReadBook, type: :model do
  describe '.all_by_date' do
    subject { HstUserReadBook.all_by_date({user_id: user.id, user_book_id: user_book.id}) }
    let(:user) { create(:user) }
    let(:user_book) { create(:user_book, user: user) }
    before do
      create(:hst_user_read_book, user: user, user_book: user_book, date: '2018-02-01', comment: 'test1')
      create(:hst_user_read_book, user: user, user_book: user_book, date: '2018-02-10', comment: 'test2')
      create(:hst_user_read_book, user: user, user_book: user_book, date: '2018-02-20', comment: 'test3')
    end

    it 'dateがキーのハッシュが返る' do
      expect(subject.count).to eq 3
      expect(subject.key?('2018-02-01')).to eq true
      expect(subject.key?('2018-02-10')).to eq true
      expect(subject.key?('2018-02-20')).to eq true
    end
  end
end
