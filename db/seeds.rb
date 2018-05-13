Publisher.delete_all
FactoryBot.create(:publisher, id: 0, name: '指定なし', class_name: 'Crawler::KodansyaCrawler')
FactoryBot.create(:publisher, name: '講談社', class_name: 'Crawler::KodansyaCrawler')
FactoryBot.create(:publisher, name: '集英社', class_name: 'Webdriver::ShueisyaCrawler')
FactoryBot.create(:publisher, name: '技術評論社', class_name: 'Crawler::GihyoCrawler')

BookCategory.delete_all
FactoryBot.create(:book_category, id: 0, name: 'Unspecified')
FactoryBot.create(:book_category, id: 1, name: 'Comic')
FactoryBot.create(:book_category, id: 2, name: 'Novel')
FactoryBot.create(:book_category, id: 3, name: 'Business')
FactoryBot.create(:book_category, id: 4, name: 'Hobby')
FactoryBot.create(:book_category, id: 5, name: 'Education')
FactoryBot.create(:book_category, id: 6, name: 'Other')