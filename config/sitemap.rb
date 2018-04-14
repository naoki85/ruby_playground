# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host  = 'https://bookrecorder.net'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  # Static Pages
  add user_policy_path,    :priority => 0.8, :changefreq => 'monthly'
  add privacy_policy_path, :priority => 0.8, :changefreq => 'monthly'
  User.find_each do |user|
    add user_path(user), lastmod: user.updated_at
  end
end
