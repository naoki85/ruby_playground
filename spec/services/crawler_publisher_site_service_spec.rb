require 'rails_helper'

RSpec.describe CrawlPublisherSiteService, type: :service do
  before do
    Book.delete_all
    allow(Webdriver::ShueisyaCrawler).to receive(:run).and_return([{ publisher_id: publisher.id,
                                                                     title: 'test',
                                                                     image_url: 'test',
                                                                     detail_page_url: 'test' }])
  end

  describe '.run' do
    let(:publisher) { FactoryBot.create(:publisher, name: '集英社', class_name: 'Webdriver::ShueisyaCrawler') }

    describe 'まだ登録されていない本の場合' do
      it '新規登録される' do
        CrawlPublisherSiteService.run(publisher.id)
        expect(Book.count).to eq 1
      end
    end
  end
end
