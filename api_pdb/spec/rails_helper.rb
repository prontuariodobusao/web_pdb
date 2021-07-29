require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require 'factory_bot_rails'
require 'database_cleaner'
require 'faker'
require 'pry-rails'
require 'pundit/rspec'

require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  include ApiHelper
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods

  config.include Rails.application.routes.url_helpers

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation, { except: %w[statuses] })
  end

  config.before(:each) do
    DatabaseCleaner.strategy = [:truncation, { except: %w[statuses] }]
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end
