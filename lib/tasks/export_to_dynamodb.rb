class Tasks::ExportToDynamodb
  def self.execute
    recommended_books = RecommendedBook.where('id > 1')
    return if recommended_books.empty?
    recommended_books.each do |book|
      item = {
          Id: book.id,
          Link: book.link,
          ImageUrl: book.image_url,
          ButtonUrl: book.button_url,
          CreatedAt: book.created_at.strftime("%Y-%m-%d %H:%M:%S"),
          UpdatedAt: book.updated_at.strftime("%Y-%m-%d %H:%M:%S")
      }
      Dynamodb::Base.save("RecommendedBooks", item)
    end
  end
end
