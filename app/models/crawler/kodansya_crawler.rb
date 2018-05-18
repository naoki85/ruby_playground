class Crawler::KodansyaCrawler < Crawler
  self.base_url = 'http://kc.kodansha.co.jp'
  self.content_list_url = 'http://kc.kodansha.co.jp/calendar'
  self.content_xpath = '//div[@class="spaceSp"]/a'

  def self.get_title(dom)
    dom.xpath('.//div[@class="tit"]').text
  end

  def self.get_article_url(dom)
    super
  end
end
