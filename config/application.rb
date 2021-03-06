require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Auction
  class Application < Rails::Application
    config.assets.precompile << 'delayed/web/application.css'
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.autoload_paths << Rails.root.join('lib/')
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)
    config.autoload_paths += %w(#{config.root}/app/interactor/)
    config.to_prepare do
      Delayed::Web::Job.backend = 'active_record'
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # Where the I18n library should search for translation files
    I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
    config.active_job.queue_adapter = :delayed_job
    config.time_zone = 'Minsk'
    config.active_record.default_timezone = :local
    # Whitelist locales available for the application
    I18n.available_locales = [:en, :ru]
  end
end
