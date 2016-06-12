require 'spec_helper'

describe RspecWebServiceOutputter::Output do
  context "to_s" do
    it 'returns string with the request and response' do
      request = double("request")
      response = double("response")
      outputter = RspecWebServiceOutputter::Output.new(request, response)
      allow(outputter).to receive(:request).and_return("Request Output")
      allow(outputter).to receive(:response).and_return("Response Output")
      output = outputter.to_s.split("\n")
      expect(output[0]).to eq("")
      expect(output[1]).to eq("Request Output")
      expect(output[2]).to eq("")
      expect(output[3]).to eq("Response Output")
    end
  end
end
