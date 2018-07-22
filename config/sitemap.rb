# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host  = 'https://bookrecorder.net'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  # Static Pages
  add user_policy_path,    :priority => 0.8, :changefreq => 'monthly'
  add privacy_policy_path, :priority => 0.8, :changefreq => 'monthly'

  # Posts
  Post.released.find_each do |post|
    add post_path(post), lastmod: post.updated_at
  end
end
