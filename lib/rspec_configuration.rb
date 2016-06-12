require 'rspec_webservice_outputter'

RSpec.configure do |config|
  config.after(:each) do
    next unless ENV['WEBSERVICE'] && request
    RspecWebServiceOutputter::Output.new(request, response).print
  end
end
