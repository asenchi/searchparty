# SearchParty

VERY MUCH A WORK IN PROGRESS DO NOT USE.

SearchParty routes search queries to various backend services (for example
Splunk) and parses the results based on that services defined response. The
goal is to be able to abstract various backends for writing user facing
services.

## Installation

Add this line to your application's Gemfile:

    gem 'searchparty'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install searchparty

## Usage

SearchParty takes a payload and sends it to a route, (a route being defined as
a named list of services). The payload should contain a "source" key and a
nested service hash named after the corresponding service. The service hash
should contain "query" and "parse" keys. Services can then be written to
handle the queries and parse the results to be sent back to the caller.

```ruby
client = SearchParty::Client.new
client.create_route("monitor_api_502", ["splunk://user:pass@splunk.example.com", "mylogservice://user:pass@my.logger.com"])
client.search("monitor_api_502", {
  :source => "hubot",
  :splunk => {
    :query => "index=production app=github status=502 earliest=-1m",
    :parse => "| stats count",
  },
  :mylogservice => {
    :query => "app=github status=502",
    :parse => "wc -l",
  }
})
```

Results for the corresponding query should look like this:

```ruby
{
  :splunk => {
    :results_url => "https://splunk.example.com/path/to/my/results",
    :results => [
      "test message 1",
      "test message 2"
    ],
  }
  :mylogservice => {
    :results_url => "https://my.logger.com/path/to/results",
    :results => [
      "test message 1",
      "test message 2",
    ],
  },
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
