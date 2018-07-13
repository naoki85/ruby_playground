class Webdriver::Kodansya < Webdriver
  class_attribute :base_url
  class_attribute :content_url

  def self.run
    driver = set_driver
    driver.navigate.to self.content_url
    elems = driver.find_elements(:css, '.block')

    data = []
    elems.size.times do |i|
      begin
        elems = driver.find_elements(:css, '.block')
        elem = elems[i]
        title = elem.find_element(:css, '.tit').text

        detail_page_url = if elem.attribute('href')
                            self.get_detail_page_url(elem.attribute('href'))
                          else
                            ''
                          end
        author = elem.find_element(:css, '.name').text
        published_at = parse_date(elem.find_element(:css, '.date').text)

        image_url = if detail_page_url.present?
                      elem.click
                      driver.find_element(:xpath, '//div[@class="lineImg"]/img').attribute('src')
                    else
                      ''
                    end
        data << { title: title, detail_page_url: detail_page_url, image_url: image_url,
                  author: author, published_at: published_at }
      rescue => e
        Rails.logger.warn e
      ensure
        # 一覧に戻る
        driver.find_element(:xpath, '//div[@class="inner"]/ul[@class="gNavi"]/li[@class="navi3"]/a').click
      end
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
    self.base_url + str
  end

  class Webdriver::Kodansya::Comic < Webdriver::Kodansya
    self.base_url = 'http://kc.kodansha.co.jp/'
    self.content_url = 'http://kc.kodansha.co.jp/calendar'
  end

  class Webdriver::Kodansya::Other < Webdriver::Kodansya
    self.base_url = 'http://bookclub.kodansha.co.jp/'
    self.content_url = 'http://bookclub.kodansha.co.jp/calendar'
  end
end
