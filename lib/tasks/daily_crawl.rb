class Tasks::DailyCrawl
  def self.execute
    CrawlPublisherSiteService.run
  end
end
