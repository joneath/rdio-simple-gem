require_relative '../lib/rdio'
require 'rspec'
require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:suite) do
    WebMock.disable_net_connect!(:allow_localhost => true)
  end
end
