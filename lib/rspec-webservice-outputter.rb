require 'rspec/core'
require 'rspec-webservice-outputter/base'

RSpec.configure do |config|
  config.after(:each) do
    next unless ENV['WEBSERVICE'] && defined?(request)
    RspecWebServiceOutputter::Output.new(request, response).print
  end
end
