SitemapGenerator::Sitemap.create(
    :default_host => 'https://bookrecorder.net',
    :sitemaps_path => 'sitemaps/bookrecorder/')

SitemapGenerator::Sitemap.create(
    :default_host => 'https://blog.bookrecorder.net',
    :sitemaps_path => 'sitemaps/blog_bookrecorder') do
  Post.released.find_each do |post|
    add post_path(post), lastmod: post.updated_at
  end
end
