module ApplicationHelper

  # For index, show, back
  def default_btn_class
    'waves-effect btn grey lighten-5 black-text'
  end

  # For new, create
  def create_btn_class
    'waves-effect waves-light btn green accent-3'
  end

  # For edit, update
  def update_btn_class
    'waves-effect waves-light btn orange accent-3'
  end

  # For delete, alert
  def danger_btn_class
    'waves-effect waves-light btn red accent-3'
  end

  # For signup, login
  def session_btn_class
    'waves-effect waves-teal btn'
  end

  def week_day_class(wday)
    case wday
    when 0 then 'wday-holiday'
    when 6 then 'wday-sat'
    else
      'wday'
    end
  end

  def default_meta_tags
    {
        title:       'BookRecorder',
        description: I18n.t('top.index.description'),
        keywords:    'Book,本',
        charset:     'utf-8',
        # 'apple-mobile-web-app-capable' => 'no',
        # 'apple-mobile-web-app-status-bar-style' => 'default',
        # 'viewport' => 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"]',
        # OGPの設定
        og: {
            title: 'BookRecorder',
            type: 'website',
            url: request.original_url,
            # image: image_url('top/banner.png'),
            site_name: 'BookRecorder',
            description: I18n.t('top.index.description'),
            locale: 'ja_JP'
        },
        twitter: {
            card: 'summary',
            site: '@tony_201612',
            creator: '@tony_201612'
        }
    }
  end

  # @param [String] detail_page_url
  # @return [String]
  def link_to_detail_page(detail_page_url)
    if detail_page_url =~ /www\.amazon\.co\.jp/
      link_to detail_page_url do
        image_tag 'commons/btn_amazon'
      end
    else
      link_to t('button.show'), detail_page_url, class: default_btn_class
    end
  end
end
