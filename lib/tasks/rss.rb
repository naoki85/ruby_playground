require 'rss'

class Tasks::Rss
  def self.dump
    return unless Rails.env.production?

    feed = RSS::Maker.make("2.0") do |feed|
      feed.channel.title = "BookRecorder のブログ"
      feed.channel.link = "https://blog.bookrecorder.net"
      feed.channel.about = "https://blog.bookrecorder.net/feed.xml"
      feed.channel.description = "BookRecorder は naoki85 によりメンテナンスされているサイトです。主に本の紹介や勉強したことをブログにまとめていきます。"
      feed.channel.updated = Time.now

      Post.released.each do |post|
        feed.items.new_item do |item|
          item.title = post.title
          item.description = post.content[0, 160].chomp
        end
      end
    end

    File.open("#{Rails.root}/public/feed.xml", 'w') { |f| f.puts(feed) }
  end
end
