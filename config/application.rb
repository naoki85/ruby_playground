require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BookRecorder
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.enable_dependency_loading = true
    config.autoload_paths += Dir["#{config.root}/lib"]
    config.base_url = 'https://naoki85.me'
    config.image_base_url = 'http://d29xhtkvbwm2ne.cloudfront.net/posts/'

    # RSpec
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: true,
                       helper_specs: true,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    # rack-cors
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
  end
end
