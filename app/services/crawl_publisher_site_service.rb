class CrawlPublisherSiteService < BaseService
  def self.run
    publishers = Publisher.where(active: 1)
    publishers.each do |publisher|
      clazz = publisher.class_name.constantize
      data = clazz.run
      data.each do |record|
        book = Book.find_or_initialize_by(publisher_id: publisher.id, title: record[:title])
        book.title = record[:title]
        book.detail_page_url = record[:detail_page_url]
        book.image_url = record[:image_url]
        book.published_at = record[:published_at]
        book.author = record[:author]
        book.save!
      end
    end
  end
end