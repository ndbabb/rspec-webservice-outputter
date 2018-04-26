require 'json'

module RspecWebServiceOutputter
  class Output
    def initialize(action_dispatch_request, action_dispatch_response)
      @action_dispatch_request = action_dispatch_request
      @action_dispatch_response = action_dispatch_response
    end

    def print
      puts self
    end

    def to_s
      "\n#{request}\n\n#{response}\n\n"
    end

    private

    def request
      Request.new(@action_dispatch_request)
    end

    def response
      Response.new(@action_dispatch_response)
    end
  end

  class Request
    def initialize(request)
      @request = request
    end

    def to_s
      "REQUEST:\n" \
      "#{@request.method} #{@request.path}#{query_string}\n#{request_body}"
    end

    private

    def query_string
      "?#{@request.query_string}" if @request.query_string && !@request.query_string.empty?
    end

    def request_body
      request_body = @request.body.read
      return unless request_body && !request_body.empty?
      begin
        JSON.pretty_generate(JSON.parse(@request.body.read))
      rescue
        "[Non-JSON request body]"
      end
    end
  end

  class Response
    def initialize(response)
      @response = response
    end

    def to_s
      "RESPONSE (#{@response.code}):\n#{response_body}"
    end

    private

    def response_body
      if @response.body
        begin
          JSON.pretty_generate(JSON.parse(@response.body))
        rescue
          "[Non-JSON response body]"
        end
      else
        "[Empty response body]"
      end
    end
  end
end
