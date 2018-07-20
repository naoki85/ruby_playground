class Webdriver::OReillyJapan < Webdriver

  def self.run
    driver = set_driver
    driver.navigate.to 'https://www.oreilly.co.jp/catalog/'
    elems = -> { driver.find_elements(:xpath, '//table[@id="bookTable"]/tbody/tr').reverse }

    data = []
    elems.call.size.times do |i|
      elem = elems.call[i]
      link = elem.find_element(:xpath, './td/a')
      detail_page_url = get_detail_page_url(link.attribute('href'))
      link.click
      begin
        title = driver.find_element(:xpath, '//h3[@class="title"]')
        image_url = driver.find_element(:xpath, '//section[@id="content"]//img').attribute('src')
        list_tags = driver.find_elements(:xpath, '//ul[@class="biblio"]/li')
        author = self.parse_author(list_tags[0].text)
        published_at = self.parse_date(list_tags[1].text)

        book_category = get_book_category(title)
        data << { title: title, detail_page_url: detail_page_url, image_url: image_url,
                  author: author, published_at: published_at, book_category: book_category }
        logger.warn data
      rescue => e
        Rails.logger.warn e
      ensure
        # 戻る
        driver.navigate.back
      end
    end
  rescue StandardError => e
    Rails.logger.error e
  ensure
    driver.quit
    data
  end

  def self.parse_date(date_str)
    if date_str =~ /(\d{4})[年\/.]\s*(\d{1,2})[月\/.]\s*(\d{1,2})[日]?\s*/
      Date.new($1.to_i, $2.to_i, $3.to_i)
    else
      raise "invalid date: #{date_str}"
    end
  end

  def self.get_detail_page_url(str)
    arr_path = str.split('/')
    relative_path = arr_path[1..-1].join('/')
    'https://www.oreilly.co.jp/' + relative_path
  end

  def self.parse_author(str)
    str.gsub('著者：', '').gsub('　', '').gsub('著作者名：', '').gsub(' ', '')
  end
end
