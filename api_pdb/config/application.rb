require_relative "boot"

require "rails"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"

Bundler.require(*Rails.groups)

module ApiPdb
  class Application < Rails::Application
    config.load_defaults 6.1
    config.api_only = true

    config.time_zone = 'America/Fortaleza'
    config.i18n.default_locale = :"pt-BR"

    config.autoload_paths << "#{Rails.root}/lib"

    config.active_record.schema_format = :sql

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot
      g.factory_bot dir: 'spec/factories'
    end
  end
end
