require 'spec_helper'

describe RspecWebServiceOutputter::Request do
  let(:request_with_body) do
    body = double("body")
    allow(body).to receive(:read).and_return('{"test": "test"}')
    request = double("request")
    allow(request).to receive(:method).and_return("POST")
    allow(request).to receive(:path).and_return("/here-is-a-path")
    allow(request).to receive(:query_string).and_return("key1=value1&key2=value2")
    allow(request).to receive(:body).and_return(body)
    return request
  end
  let(:request_empty_body) do
    body = double("body")
    allow(body).to receive(:read).and_return(nil)
    request = double("request")
    allow(request).to receive(:method).and_return("POST")
    allow(request).to receive(:path).and_return("/here-is-a-path")
    allow(request).to receive(:query_string).and_return("key1=value1&key2=value2")
    allow(request).to receive(:body).and_return(body)
    return request
  end
  let(:request_with_non_json) do
    body = double("body")
    allow(body).to receive(:read).and_return('some non-json text')
    request = double("request")
    allow(request).to receive(:method).and_return("POST")
    allow(request).to receive(:path).and_return("/here-is-a-path")
    allow(request).to receive(:query_string).and_return("key1=value1&key2=value2")
    allow(request).to receive(:body).and_return(body)
    return request
  end
  context "to_s" do
    it 'returns string that starts with REQUEST:' do
      output = RspecWebServiceOutputter::Request.new(request_empty_body).to_s.split("\n")
      expect(output[0]).to eq("REQUEST:")
    end
    it 'returns string with request summary (method, path and query string)' do
      output = RspecWebServiceOutputter::Request.new(request_empty_body).to_s.split("\n")
      expect(output[1]).to eq("POST /here-is-a-path?key1=value1&key2=value2")
    end
    it 'returns string with request body when present' do
      output = RspecWebServiceOutputter::Request.new(request_with_body).to_s.split("\n")
      expect(output[2]).to eq("{")
      expect(output[3]).to eq("  \"test\": \"test\"")
      expect(output[4]).to eq("}")
    end
    it 'returns only the request summary when no request body' do
      output = RspecWebServiceOutputter::Request.new(request_empty_body).to_s.split("\n")
      expect(output[0]).to eq("REQUEST:")
      expect(output[1]).to eq("POST /here-is-a-path?key1=value1&key2=value2")
      expect(output.size).to eq(2)
    end
    it 'returns [Non-JSON request body] when non-empty non-JSON in body' do
      output = RspecWebServiceOutputter::Request.new(request_with_non_json).to_s.split("\n")
      expect(output[2]).to eq("[Non-JSON request body]")
    end
  end
end
