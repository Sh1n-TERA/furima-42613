source "https://rubygems.org"

ruby "3.2.0"

gem "rails", "~> 7.1.0"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mswin mingw x64_mingw jruby ]
gem "bootsnap", require: false
gem "devise"
gem "mini_magick"
gem "image_processing", "~> 1.2"
gem "active_hash"
gem "dotenv-rails"
gem 'mysql2', '~> 0.5'

group :development, :test do
  gem "debug", platforms: %i[ mri mswin mingw x64_mingw ]
  gem "rspec-rails", "~> 4.0.0"
  gem "factory_bot_rails"
  gem "faker"
  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano3-unicorn'
end

group :development do
  gem "web-console"
  gem "rubocop", "1.71.2", require: false
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

group :production do
  gem 'unicorn', '6.1.0'
end

gem "nokogiri", force_ruby_platform: true