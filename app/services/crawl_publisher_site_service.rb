class CrawlPublisherSiteService < BaseService
  def self.run
    Rails.logger.info 'Start crawling...'
    publishers = Publisher.where(active: 1).where('last_fetched_at < ?', DateTime.now - 3)
    publishers.each do |publisher|
      Rails.logger.info "Start #{publisher.name}"
      clazz = publisher.class_name.constantize
      data = clazz.run
      Rails.logger.info "data = #{data}"
      data.each do |record|
        book = Book.find_or_initialize_by(publisher_id: publisher.id, title: record[:title])
        book.title = record[:title]
        book.detail_page_url = record[:detail_page_url]
        book.image_url = record[:image_url]
        book.published_at = record[:published_at]
        book.author = record[:author]
        book.save!
      end
      publisher.last_fetched_at = DateTime.now
      publisher.save
      Rails.logger.info "Finish #{publisher.name}"
    end
    Rails.logger.info 'Finish crawling'
  end
end