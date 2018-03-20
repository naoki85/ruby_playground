class Webdriver::ShueisyaCrawler < Webdriver

  def self.run
    driver = set_driver
    driver.navigate.to 'http://www.s-manga.net/newbook/index.html'
    elems = driver.find_elements(:css, 'section.single-item')

    data = []
    elems.each do |elem|
      title = elem.find_element(:xpath, './/h2').text
      detail_page_url = elem.find_element(:xpath, './/h2//a').attribute('href')
      image_url = elem.find_element(:xpath, './/figure//img').attribute('src')
      data << { title: title, detail_page_url: detail_page_url, image_url: image_url }
    end
    driver.quit
    data
  end
end
