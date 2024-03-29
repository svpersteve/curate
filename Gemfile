source 'https://rubygems.org'
ruby '2.4.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

gem 'modernizr-rails'
gem 'autoprefixer-rails'
gem 'haml'
gem 'haml-rails'

gem 'thin'
gem 'nokogiri'

gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'devise'
gem 'devise-i18n'
gem 'omniauth'
gem 'omniauth-instagram'
gem 'omniauth-facebook'
gem "recaptcha", require: "recaptcha/rails"

gem 'friendly_id'

gem 'cancancan'
gem "rolify"

gem 'carrierwave'
gem 'fog'
gem 'mini_magick'
gem 'ckeditor', github: 'galetahub/ckeditor'

gem 'stripe'
gem 'omniauth-stripe-connect'

gem 'countries', :require => 'countries/global'
gem 'rails_autolink'

gem 'ransack', github: 'activerecord-hackery/ransack'

group :development, :test do
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'pry'
  gem 'rspec-rails', '~> 3.5'
  gem 'rubocop', '~> 0.47.1', require: false
  gem 'poltergeist'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'scss_lint', require: false
  gem 'railroady'
  gem 'launchy'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'database_cleaner'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
