require 'rails_helper'

RSpec.describe CrawlPublisherSiteService, type: :service do
  before do
    Book.delete_all
    BookCategory.delete_all
    FactoryBot.create(:book_category, id: 0, name: 'none')
    allow(Webdriver::Shueisya).to receive(:run).and_return([{ publisher_id: publisher.id,
                                                              title: 'test',
                                                              author: 'test',
                                                              image_url: 'test',
                                                              published_at: Date.today,
                                                              detail_page_url: 'test',
                                                              book_category: 'Ruby' }])
  end

  describe '.run' do
    let(:publisher) {
      FactoryBot.create(:publisher,
                        name: '集英社',
                        class_name: 'Webdriver::Shueisya',
                        last_fetched_at: '2018-01-01 00:00:00'
      )
    }

    before do
      FactoryBot.create(:publisher,
                        name: '講談社',
                        class_name: 'Webdriver::Kodansya',
                        last_fetched_at: DateTime.now - 1
      )
    end

    describe 'まだ登録されていない本の場合' do
      it '新規登録される' do
        before_count = BookCategory.count
        CrawlPublisherSiteService.run
        expect(Book.count).to eq 1
        publisher.reload
        expect(publisher.last_fetched_at.strftime('%Y-%m-%d')).to eq Time.zone.now.strftime('%Y-%m-%d')
        expect(BookCategory.count).to eq before_count + 1
      end
    end
  end
end
