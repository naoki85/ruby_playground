class Crawler::KodansyaCrawler < Crawler
  @@base_url = 'http://kc.kodansha.co.jp'
  @@content_list_url = 'http://kc.kodansha.co.jp/calendar'
  @@title_xpath = '//div[@class="spaceSp"]/a'

  def self.get_title(dom)
    dom.xpath('.//div[@class="tit"]').text
  end

  def self.get_article_url(dom)
    super
  end
end
