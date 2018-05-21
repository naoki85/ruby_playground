class CrawlPublisherSiteService < BaseService
  def self.run
    Rails.logger.info 'Start crawling...'
    publishers = Publisher.where(active: 1)
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
      Rails.logger.info "Finish #{publisher.name}"
    end
    Rails.logger.info 'Finish crawling'
  end
end