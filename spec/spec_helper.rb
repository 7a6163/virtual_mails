# frozen_string_literal: true

require 'simplecov'
require 'coveralls'

if ENV['COVERAGE']
  SimpleCov.start 'rails' do
    add_filter 'app/helpers'
    add_filter 'lib/virtual_mails/version'
  end
else
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  Coveralls.wear!
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('dummy/config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'virtual_mails'
require 'rspec/its'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each do |file|
  require file
end

include VirtualMails
