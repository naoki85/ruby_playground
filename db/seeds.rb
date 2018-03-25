Publisher.delete_all
FactoryBot.create(:publisher, id: 0, name: '指定なし', class_name: 'Crawler::KodansyaCrawler')
FactoryBot.create(:publisher, name: '講談社', class_name: 'Crawler::KodansyaCrawler')
FactoryBot.create(:publisher, name: '集英社', class_name: 'Webdriver::ShueisyaCrawler')

BookCategory.delete_all
FactoryBot.create(:book_category, id: 0, name: '指定なし')