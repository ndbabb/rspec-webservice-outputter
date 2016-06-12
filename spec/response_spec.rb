require 'spec_helper'

describe RspecWebServiceOutputter::Response do
  let(:response_with_body) do
    response = double("response")
    allow(response).to receive(:code).and_return("204")
    allow(response).to receive(:body).and_return('{"test": "test"}')
    return response
  end
  let(:response_empty_body) do
    response = double("response")
    allow(response).to receive(:code).and_return("204")
    allow(response).to receive(:body).and_return(nil)
    return response
  end
  let(:response_with_non_json) do
    response = double("response")
    allow(response).to receive(:code).and_return("204")
    allow(response).to receive(:body).and_return("Some non-JSON text")
    return response
  end
  context "to_s" do
    it 'returns string that starts with RESPONSE([status_code]):' do
      output = RspecWebServiceOutputter::Response.new(response_with_body).to_s.split("\n")
      expect(output[0]).to eq("RESPONSE (204):")
    end
    it 'returns string with response body when present' do
      output = RspecWebServiceOutputter::Response.new(response_with_body).to_s.split("\n")
      expect(output[1]).to eq("{")
      expect(output[2]).to eq("  \"test\": \"test\"")
      expect(output[3]).to eq("}")
    end
    it 'returns [Empty response body] when no response body' do
      output = RspecWebServiceOutputter::Response.new(response_empty_body).to_s.split("\n")
      expect(output[1]).to eq("[Empty response body]")
    end
    it 'returns [Non-JSON response body] when non-empty non-JSON in body' do
      output = RspecWebServiceOutputter::Response.new(response_with_non_json).to_s.split("\n")
      expect(output[1]).to eq("[Non-JSON response body]")
    end
  end
end
