class Webdriver::NikkeiBP < Webdriver

  def self.run
    driver = set_driver
    driver.navigate.to 'https://shop.nikkeibp.co.jp/front/app/catalog/list/?searchBookSearchFlg=1'
    elems = driver.find_elements(:xpath, '//ul[@id="imageModeArea"]/li')

    data = []
    now_page_count = nil
    5.times do |j|
      if j > 0
        10.times do
          next_page_count = driver.find_elements(:xpath, '//ul[@class="lyt-list"]//b')[1].text
          next if now_page_count == next_page_count
          now_page_count = next_page_count
        end
        break if now_page_count != next_page_count
      else
        now_page_count = driver.find_elements(:xpath, '//ul[@class="lyt-list"]//b')[1].text
      end
      elems.size.times do |i|
        begin
          elems = driver.find_elements(:xpath, '//ul[@id="imageModeArea"]/li')
          elem = elems[i]
          title = elem.find_element(:css, '.list-hdg').text

          link = elem.find_element(:xpath, './/a')
          detail_page_url = get_detail_page_url(link.attribute('href'))
          link.click

          image_url = driver.find_element(:xpath, '//img[@id="mainImage"]').attribute('src')
          grid_cols = driver.find_elements(:xpath, '//div[@class="detail-grid grid"]/div[@class="grid-col"]')
          published_at = self.parse_date(grid_cols[1].find_element(:xpath, './/dd').text)
          author = grid_cols[5].find_element(:xpath, './/dd').text

          data << { title: title, detail_page_url: detail_page_url, image_url: image_url,
                    author: author, published_at: published_at }
        rescue => e
          Rails.logger.warn e
        ensure
          # 戻る
          driver.navigate.back
        end
      end
      next_link = driver.find_element(:xpath, '//a[@class="pagingNext pagingLink"]')
      next_link.click
    end
    driver.quit
    data
  rescue StandardError => e
    Rails.logger.error e
    driver.quit
  end

  def self.parse_date(date_str)
    if date_str =~ /(\d{4})[年\/.]\s*(\d{1,2})[月\/.]\s*(\d{1,2})[日]?\s*/
      Date.new($1.to_i, $2.to_i, $3.to_i)
    else
      raise "invalid date: #{date_str}"
    end
  end

  def self.get_detail_page_url(str)
    'https://shop.nikkeibp.co.jp' + str
  end
end
