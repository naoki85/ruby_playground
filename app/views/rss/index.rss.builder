xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "naoki85 のブログ"
    xml.description "本ブログは naoki85 によりメンテナンスされているサイトです。主に本の紹介や勉強したことをブログにまとめていきます。"
    xml.link root_url
    xml.pubDate Time.zone.now.rfc822
    xml.language "ja-ja"
    xml.ttl "40"
    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.summary
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.guid post_url(post.id)
        xml.link post_url(post.id)
      end
    end
  end
end
