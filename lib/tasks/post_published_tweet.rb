require 'twitter'

class Tasks::PostPublishedTweet
  def self.execute
    posts = Post.select(%i[id title])
                .where('published_at >= ?', Time.zone.now.beginning_of_day)
                .where('published_at <= ?', Time.zone.now)
                .where(active: 1)
    return if posts.empty?
    posts.each do |post|
      tweet_text = post.title + "\n"
      tweet_text = tweet_text + BookRecorder::Application.config.blog_url + '/posts/' + post.id.to_s
      twitter_client.update(tweet_text)
    end
  end

  def self.twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end
end
