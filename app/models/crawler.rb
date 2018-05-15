require 'uri'
require 'open-uri'
require 'nokogiri'

class Crawler
  class_attribute :base_url
  class_attribute :content_list_url
  class_attribute :content_xpath
  class_attribute :next_url_xpath
  class_attribute :page_num
  class_attribute :sleep_time
  self.base_url = 'http://gihyo.jp'
  self.content_list_url = 'http://gihyo.jp/contentslist'
  self.content_xpath = '//*[@id="latestArticle"]/dl/dd/h3/a'
  self.next_url_xpath = '//*[@id="latestArticle"]/div[4]/p[2]/a'
  self.page_num = 2
  self.sleep_time = 1

  # @return hash
  # { title: 'book', url: 'link', published_at: '2018-05-11',
  # image_url: 'xxxx', author: 'xxxxx' }
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
    results
  end

  def self.read_html(url)
    charset = nil
    user_agent = {"User-Agent" => "Gihyo Bot"}
    html = open(url, user_agent) do |f|
      charset = f.charset
      f.read
    end
    Nokogiri::HTML.parse(html, nil, charset)
  rescue StandardError => e
    p "Error: #{e}"
  end

  def self.scrape_content_page(dom)
    ret_arr = []
    dom.xpath(self.content_xpath).each do |dom_by_xpath|
      title = get_title(dom_by_xpath)
      url   = get_article_url(dom_by_xpath)
      published_at = get_published_at(dom_by_xpath)
      image_url = get_image_url(dom_by_xpath)
      author = get_author(dom_by_xpath)
      ret_arr << { title: title, detail_page_url: url, published_at: published_at,
                   image_url: image_url, author: author }
    end
    ret_arr
  end

  def self.get_title(dom)
    dom.inner_text
  end

  def self.get_article_url(dom)
    url = dom.attribute('href').value
    URI.join(self.base_url, url).to_s
  end

  def self.get_published_at(dom)
    raise 'abstract method'
  end

  def self.get_image_url(dom)
    raise 'abstract method'
  end

  def self.get_author(dom)
    raise 'abstract method'
  end

  def self.get_next_url(dom)
    next_url = dom.xpath(self.next_url_xpath)[0].attribute('href').value
    return URI.join(self.base_url, next_url).to_s
  rescue
    return nil
  end

  def self.parse_date(date_str)
    if date_str =~ /^(\d{4})[年](\d{1,2})[月](\d{1,2})[日]\s*/
      Date.new($1.to_i, $2.to_i, $3.to_i)
    else
      raise "invalid date: #{str}"
    end
  end

  def self.parse_author(str)
    str.gsub('著', '').gsub('　', '')
  end
end
