class Crawler::Mynavi < Crawler
  self.base_url = 'https://book.mynavi.jp'
  self.content_list_url = 'https://book.mynavi.jp/ec/products/?order_type=release_date&elapsed_days%5B0%5D=reservation&elapsed_days%5B1%5D=month&search_x=70&search_y=0'
  self.content_xpath = '//ul[@class="category_list"]/li'
  self.next_url_xpath = ''
  self.page_num = 4

  @now_page = 1

  def self.get_title(dom)
    dom.xpath('.//dl/dt/a').text
  end

  def self.get_article_url(dom)
    dom.xpath('.//dl/dt/a').attribute('href').value
  end

  def self.get_published_at(dom)
    cols = dom.xpath('.//dl/dd')
    date_str = ''
    cols.each do |col|
      if col.text =~ /発売日/
        date_str = col.text
        break
      end
    end
    parse_date(date_str)
  end

  def self.get_image_url(dom)
    image_path = dom.xpath('.//div[@class="image"]//img').attribute('src').value
    URI.join(self.base_url, image_path).to_s
  end

  def self.get_author(dom)
    cols = dom.xpath('.//dl/dd')
    author = ''
    cols.each do |col|
      if col.text =~ /著作者名/
        author = col.text
        break
      end
    end
    parse_author(author)
  end

  def self.get_next_url(dom)
    @now_page = @now_page + 1
    return nil if @now_page > self.page_num
    "#{self.content_list_url}&pageID=#{@now_page}"
  end
end
