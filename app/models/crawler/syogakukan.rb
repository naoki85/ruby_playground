class Crawler::Syogakukan < Crawler
  class_attribute :now_page
  self.page_num = 5
  self.now_page = 1

  def self.get_title(dom)
    dom.xpath('.//p[@class="ttl"]').text
  end

  def self.get_article_url(dom)
    dom.xpath('.//p[@class="ttl"]/a').attribute('href').value
  end

  def self.get_published_at(dom)
    date_str = dom.xpath('.//p[@class="date"]').text
    parse_date(date_str)
  end

  def self.get_image_url(dom)
    src_path = dom.xpath('.//div[@class="image01"]//img').attribute('data-original').value
    URI.join(self.base_url, src_path).to_s
  end

  def self.get_author(dom)
    author = dom.xpath('//div[@class="txt01 clearfix"]/p[2]').text
    parse_author(author)
  end

  def self.get_book_category(title)
    'Comic'
  end

  def self.get_next_url(dom)
    self.now_page = self.now_page + 1
    self.content_list_url + '&page=' + self.now_page.to_s
  end

  class Crawler::Syogakukan::Comic < Crawler::Syogakukan
    self.base_url = 'https://www.shogakukan.co.jp'
    self.content_list_url = 'https://www.shogakukan.co.jp/comics/type/all?sort=new'
    self.content_xpath = '//ul[@class="bookBoxIn01"]/li'
  end
end
