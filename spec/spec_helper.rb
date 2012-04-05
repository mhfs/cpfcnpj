require File.join(File.dirname(__FILE__), '..', 'application.rb')

require 'rspec'
require 'rack/test'
require 'capybara'
require 'capybara/rspec'
require 'capybara/webkit'
require 'net/http'
require 'pry'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Capybara::DSL
end

def app
  Sinatra::Application
end

Capybara.app = app
Capybara.default_selector = :css
Capybara.javascript_driver = :webkit
