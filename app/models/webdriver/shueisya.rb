class Webdriver::Shueisya < Webdriver

  def self.run
    driver = set_driver
    driver.navigate.to 'http://www.s-manga.net/newbook/index.html'
    elems = driver.find_elements(:css, 'section.single-item')

    data = []
    elems.each do |elem|
      title = elem.find_element(:xpath, './/h2').text
      detail_page_path = elem.find_element(:xpath, './/h2//a').attribute('href')
      detail_page_url = self.get_detail_page_url(detail_page_path)
      image_url = elem.find_element(:xpath, './/figure//img').attribute('src')
      paragraphes = elem.find_elements(:xpath, './/p')
      author = paragraphes[0].text
      published_at = parse_date(paragraphes[1].text)
      data << { title: title, detail_page_url: detail_page_url, image_url: image_url,
                author: author, published_at: published_at }
    end
    driver.quit
    data
  rescue StandardError => e
    Rails.logger.error e
    driver.quit
  end

  def self.parse_date(date_str)
    if date_str =~ /(\d{4})[年\/]\s*(\d{1,2})[月|\/]\s*(\d{1,2})[日]?\s*/
      Date.new($1.to_i, $2.to_i, $3.to_i)
    else
      raise "invalid date: #{date_str}"
    end
  end

  def self.get_detail_page_url(detail_page_path)
    detail_page_path = detail_page_path.gsub('..', '')
    'http://www.s-manga.net/' + detail_page_path
  end
end