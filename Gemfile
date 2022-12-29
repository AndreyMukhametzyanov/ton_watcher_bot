# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'
gem 'bootsnap', require: false
gem 'nokogiri'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4'
gem 'redis'
gem 'rubocop'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'telegram-bot'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'watir'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'foreman'
end

group :development do
  gem 'bundler-audit'
end
