class Webdriver::SbCreative < Webdriver

  def self.run
    driver = set_driver
    driver.navigate.to 'http://www.sbcr.jp/pc/'
    elems = driver.find_elements(:xpath, '//div[@class="topLeftColumnCategoryItem"]')

    data = []
    elems.size.times do |i|
      begin
        elems = driver.find_elements(:xpath, '//div[@class="topLeftColumnCategoryItem"]')
        link = elems[i].find_element(:xpath, './/a[@class="categoryTitleLink"]')
        detail_page_url = link.attribute('href')
        link.click

        main_img = driver.find_element(:xpath, '//img[@id="mainImage"]')
        title = main_img.attribute('alt')
        image_url = main_img.attribute('src')
        author = self.parse_author(driver.find_element(:css, '.detailTitleRightAuthorRight-inner.pkg').text)
        published_at = self.parse_date(driver.find_element(:css, '.detailTitleRightPublishDateRight-inner.pkg').text)

        break if Date.today - 30 > published_at

        data << { title: title, detail_page_url: detail_page_url, image_url: image_url,
                  author: author, published_at: published_at }
      rescue => e
        Rails.logger.warn e
      ensure
        # 戻る
        driver.navigate.back
      end
    end
    driver.quit
    data
  rescue StandardError => e
    Rails.logger.error e
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

  def self.parse_author(str)
    str.gsub('　', '').gsub('著', '').gsub(' ', '')
  end
end
