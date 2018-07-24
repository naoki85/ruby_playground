class Crawler::Gihyo < Crawler
  self.base_url = 'http://gihyo.jp'
  self.content_list_url = 'http://gihyo.jp/book/list'
  self.content_xpath = '//ul[@class="magazineList01 bookList01"]/li[@class="clearfix"]'
  self.next_url_xpath = '//p[@class="next"]/a'
  self.page_num = 5

  def self.run
    results = []
    url = self.content_list_url
    self.page_num.times do
      dom = read_html(url)
      tmp_result = scrape_content_page(dom)
      results.concat(tmp_result)
      url = get_next_url(dom)
      break if url.nil?
      sleep(self.sleep_time)
    end
    dom = read_html('http://gihyo.jp/magazine/SD')
    results << get_magazine_detail(dom)
    dom = read_html('http://gihyo.jp/magazine/wdpress')
    results << get_magazine_detail(dom)
    results
  end

  def self.get_title(dom)
    dom.xpath('.//h3').text
  end

  def self.get_article_url(dom)
    url = dom.xpath('.//h3/a').attribute('href').value
    URI.join(self.base_url, url).to_s
  end

  def self.get_published_at(dom)
    date_str = dom.xpath('.//p[@class="sellingdate"]').text
    parse_date(date_str)
  end

  def self.get_image_url(dom)
    src = dom.xpath('.//div[@class="cover"]//img').attribute('data-original')
    unless src
      src = dom.xpath('.//div[@class="cover"]//img').attribute('src')
    end
    src.value
  end

  def self.get_author(dom)
    author = dom.xpath('.//p[@class="author"]').text
    parse_author(author)
  end

  def self.get_magazine_detail(dom)
    title = dom.xpath('//div[@class="data"]//h2/a').text
    published_at = parse_date(dom.xpath('//div[@class="information"]/p').text)
    url   = dom.xpath('//div[@id="backNumber"]//ul/li[1]//h3/a').attribute('href').value
    image_url = get_image_url(dom.xpath('//div[@id="newPublishedInfo"]'))
    author = '技術評論社'
    book_category = 'Magazine'
    { title: title, detail_page_url: url, published_at: published_at,
      image_url: image_url, author: author, book_category: book_category }
  end
end
