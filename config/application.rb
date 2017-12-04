require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Zalogika
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.load_path += Dir[Rails.root.join('public', 'uploads', 'locales', '*.{yml}').to_s]
    config.i18n.default_locale = :ru
    config.active_job.queue_adapter = :sidekiq
    config.autoload_paths += %W(#{config.root}/app/services #{config.root}/lib )
    config.exceptions_app = self.routes
  end
end