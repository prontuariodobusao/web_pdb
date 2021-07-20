source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '~> 6.1.3.2'

gem 'bootsnap', '>= 1.4.4', require: false

gem 'api_pack', '~> 1.3.1'
gem 'bcrypt', '~> 3.1.7'
gem 'blueprinter'
gem 'jwt'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit'
gem 'rack-cors'
gem 'rack-mini-profiler'
gem 'rolify'
gem 'validators'
gem 'will_paginate', '~> 3.1.0'

gem 'rswag'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard-rspec', require: false
  gem 'json_matchers'
  gem 'json-schema_builder'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'

  gem 'rails-erd'

  gem 'rubocop', require: false
  gem 'rubycritic', require: false
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'traceroute'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
