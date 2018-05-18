class Crawler::Ohmsya < Crawler
  self.base_url = 'https://www.ohmsha.co.jp'
  self.content_list_url = 'https://www.ohmsha.co.jp/book/new_books.htm'
  self.content_xpath = '//div[@class="productBookList"]'
  self.next_url_xpath = '//li[@class="Next"]/a'
  self.page_num = 5

  def self.get_title(dom)
    dom.xpath('.//h3').text
  end

  def self.get_article_url(dom)
    url = dom.xpath('.//h3/a').attribute('href').value
    URI.join(self.base_url, url).to_s
  end

  def self.get_published_at(dom)
    date_str = dom.xpath('.//p[@class="sellDateTime"]').text
    parse_date(date_str)
  end

  def self.get_image_url(dom)
    src_path = dom.xpath('.//div[@class="image"]//img').attribute('src').value
    URI.join(self.base_url, src_path).to_s
  end

  def self.get_author(dom)
    author = dom.xpath('.//p[@class="authorName"]').text
    parse_author(author)
  end
end
