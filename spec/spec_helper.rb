require File.join(File.dirname(__FILE__), '..', 'application.rb')

require 'spec'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'net/http'

Spec::Runner.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Capybara
end

def app
  Sinatra::Application
end

Capybara.app = app
Capybara.default_selector = :css

def using_javascript(driver = :selenium)
  Capybara.current_driver = driver
  yield
ensure
  Capybara.use_default_driver
end
