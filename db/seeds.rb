Publisher.delete_all
FactoryBot.create(:publisher, name: '講談社', class_name: 'Crawler::KodansyaCrawler')
FactoryBot.create(:publisher, name: '集英社', class_name: 'Webdriver::ShueisyaCrawler')