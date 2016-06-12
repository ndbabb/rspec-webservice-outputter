# rspec-webservice-outputter

Developing a JSON API in Rails? The rspec-webservice-outputter gem will print the JSON request/response data when running your rspec request specs. 

There are some other tools for inspecting HTTP request/response data such as the Chrome DevTools or the Postman Chrome extension. This gem takes a different approach by providing a method to inspect the HTTP request/response from the command-line when running/debugging tests. 

# Installation

In your Rails Gemfile, add:

```ruby
group :test do
  gem 'rspec-webservice-outputter'
end
```

# Usage

When running your request spec(s), set an environmental variable call WEBSERVICE:

```
WEBSERVICE=1 rspec path_to_your_spec.rb
```

The rspec example's output will look like:

```
REQUEST:
POST /v1/some_url
{
  "some_field": 5,
  "another_field": "2016-06-08"
}

RESPONSE (201):
{
  "id": 55,
  "some_field": 5,
  "another_field": "2016-06-08"
  "created_at": "2016-06-09T01:35:41.709Z",
  "updated_at": "2016-06-09T01:35:41.709Z"
}
```

If your response body is empty (e.g. 204 No Content), you'll see:

```
RESPONSE (204):
[Empty response body]
```

If your response body's JSON data can't be parsed, you'll see:

```
RESPONSE (200):
[Non-JSON response body]
```

# Future Possibilities
 - Explore ways of implementing as a rspec custom formatter instead of an after hook
 - Or, toggle output via switch instead of env variable
 - Support XML webservices