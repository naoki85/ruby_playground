require 'twitter'

class Tasks::PostPublishedTweet

  def self.execute
    posts = Post.select([:id, :title]).where(published_at: Date.today, active: :published)
    return if posts.empty?
    posts.each do |post|
      tweet_text = post.title + ' '
      tweet_text = tweet_text + 'https://blog.bookrecorder/posts/' + post.id.to_s
      twitter_client.update(tweet_text)
    end
  end

  private

  def self.twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end
end