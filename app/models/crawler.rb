require 'uri'
require 'open-uri'
require 'nokogiri'

class Crawler
  @@base_url = 'http://gihyo.jp'
  @@content_list_url = 'http://gihyo.jp/contentslist'
  @@title_xpath = '//*[@id="latestArticle"]/dl/dd/h3/a'

  # @return hash
  # { title: 'book', url: 'link' }
  def self.run
    dom = read_html(@@content_list_url)
    data = []
    scrape_content_page(dom).each do |title, url|
      data << {title: title, url: url}
    end
    data
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
    dom.xpath(@@title_xpath).each do |dom_by_xpath|
      title = get_title(dom_by_xpath)
      url   = get_article_url(dom_by_xpath)
      ret_arr << [title, url]
    end
    ret_arr
  end

  def self.get_title(dom)
    dom.inner_text
  end

  def self.get_article_url(dom)
    url = dom.attribute('href').value
    URI.join(@@base_url, url).to_s
  end
end
