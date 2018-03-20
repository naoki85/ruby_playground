require 'selenium-webdriver'

class Webdriver

  # @return Selenium::WebDriver
  def self.set_driver
    Selenium::WebDriver.logger.level = :debug
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    Selenium::WebDriver.for :chrome, options: options
  end

  def self.run
    raise 'abstract method'
  end
end
