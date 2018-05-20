require 'rails_helper'

describe BookDecorator do
  let(:book) { Book.new.extend BookDecorator }
  subject { book }
  it { should be_a Book }

  describe '#book_image_url' do
    before {book.image_url = 'test' }
    it do
      book.image_url = 'test'
      expect(book.book_image_url).to eq 'test'
      book.image_url = ''
      expect(book.book_image_url.present?).to eq true
    end
  end
end
