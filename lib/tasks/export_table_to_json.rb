class Tasks::ExportTableToJson
  def self.execute
    recommended_books = RecommendedBook.where('id > 1')
    return if recommended_books.empty?
    result = {
        RecommendedBooks: []
    }
    recommended_books.each do |book|
      item = {
          PutRequest: {
              Id: { N: book.id.to_s },
              Link: { S: book.link },
              ImageUrl: { S: book.image_url },
              ButtonUrl: { S: book.button_url },
              CreatedAt: { S: book.created_at.strftime("%Y-%m-%d %H:%M:%S") },
              UpdatedAt: { S: book.updated_at.strftime("%Y-%m-%d %H:%M:%S") }
          }
      }
      result[:RecommendedBooks] << item
    end

    File.open("/var/log/recommended_books.json","w") {|file|
      file.puts result.to_json
    }
  end
end