require 'amazon/ecs'

class AmazonEcs
  AWS_ACCESS_KEY_ID = ENV['AWS_ACCESS_KEY_ID']
  AWS_SECRET_KEY    = ENV['AWS_SECRET_KEY']
  ASSOCIATE_TAG     = ENV['ASSOCIATE_TAG']

  def initialize
    Amazon::Ecs.configure do |options|
      options[:AWS_access_key_id] = AWS_ACCESS_KEY_ID
      options[:AWS_secret_key] = AWS_SECRET_KEY
      options[:associate_tag] = ASSOCIATE_TAG
    end
  end

  def item_search(key_word, options)
    params = {
        :search_index => 'Books',
        :response_group => 'Medium',
        :country => 'jp'
    }
    begin
      Amazon::Ecs.item_search(key_word, params)
    rescue Amazon::RequestError
      nil
    end
  end
end