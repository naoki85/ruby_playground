class Crawler::GihyoCrawler < Crawler
  self.base_url = 'http://gihyo.jp'
  self.content_list_url = 'http://gihyo.jp/book/list'
  self.content_xpath = '//ul[@class="magazineList01 bookList01"]/li[@class="clearfix"]'
  self.next_url_xpath = '//p[@class="next"]/a'

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
    dom.xpath('.//div[@class="cover"]//img').attribute('src').value
  end

  def self.get_author(dom)
    author = dom.xpath('.//p[@class="author"]').text
    parse_author(author)
  end
end
