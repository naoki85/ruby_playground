module ApplicationHelper
  def default_meta_tags
    {
        title:       'naoki85 のブログ',
        description: I18n.t('top.index.description'),
        keywords:    'Book,本',
        charset:     'utf-8',
        # 'apple-mobile-web-app-capable' => 'no',
        # 'apple-mobile-web-app-status-bar-style' => 'default',
        # 'viewport' => 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"]',
        # OGPの設定
        og: {
            title: 'naoki85 のブログ',
            type: 'website',
            url: request.original_url,
            image: image_url('commons/ogp.png'),
            site_name: 'naoki85 のブログ',
            description: I18n.t('top.index.description'),
            locale: 'ja_JP'
        },
        twitter: {
            card: 'summary_large_image',
            site: '@tony_201612',
            creator: '@tony_201612'
        }
    }
  end

  def posts_meta_tags(description='')
    {
        title: 'ブログ一覧',
        description: description,
        og: {
            title: 'ブログ一覧',
            description: description,
        },
        twitter: {
            card: 'summary_large_image',
        }
    }
  end

  # 記事詳細ページのmetaタグ
  # @param  [Post] post
  # @return [Hash]
  def post_meta_tags(post)
    {
        title: post.title,
        description: post.summary,
        og: {
            title: post.title,
            description: post.summary,
            image: post_ogp_image(post.post_image_path),
        },
        twitter: {
            card: 'summary',
        }
    }
  end

  private

  # ActiveStorageで生成したパスだとドメインがつかない
  # @param [String] image_path
  # @return [String]
  def post_ogp_image(image_path)
    if image_path !~ /^https/
      "https://#{request.host}#{image_path}"
    else
      image_path
    end
  end
end
