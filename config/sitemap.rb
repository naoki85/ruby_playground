SitemapGenerator::Sitemap.create(
    :default_host => 'https://naoki85.me',
    :sitemaps_path => 'sitemaps/naoki85') do
  Post.released.find_each do |post|
    add post_path(post), lastmod: post.updated_at
  end
end
