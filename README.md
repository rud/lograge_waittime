# LogrageRailsRequestQueuing

[![Build Status](https://travis-ci.org/rud/lograge_rails_request_queuing.svg?branch=master)](https://travis-ci.org/rud/lograge_rails_request_queuing)

[Lograge](https://github.com/roidrage/lograge) makes Rails logging output a lot more more useful.
Using the logstash formatter, the log output for a request will look something like this:

```
status=200 duration=58.33 view=40.43 db=15.26 controller=WelcomeController action=show
```

This gem adds another field with how long the request spent in the request queue in nginx in milliseconds, the `rq` value:

```
status=200 duration=58.33 view=40.43 db=15.26 rq=3.14 [...]
```

Request queueing time is the time that passes between a request is received in Nginx, and until it hits the Rails stack in a web worker.
Under normal load in production this value will be in the order of a handful milliseconds.
However, if all Rails web-processes are busy, the number will quickly climb as individual requests are queued and waiting to be served.
It's one of those numbers that are good to keep an eye on in monitoring and is very helpful to include when graphing response times over time.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lograge_rails_request_queuing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lograge_rails_request_queuing

Then add it to your lograge initializer, typically in `config/initializers/lograge.rb`:

``` ruby
Rails.application.configure do
  config.lograge.enabled = true

  # Keep emitting the verbose logging for easier debug
  config.lograge.keep_original_rails_log = !Rails.env.production?

  config.lograge.custom_options = lambda do |event|
    custom_options = {}

    queued_ms = RequestStore[:lograge_request_queueing].queued_ms
    custom_options[:rq] = queued_ms.round(2) if queued_ms

    custom_options
  end
end
```

In your nginx config, add:
```
proxy_set_header X-Request-Start "t=${msec}";`
```

This adds a new header to the incoming request, with current time in milliseconds as the value. 

After this is deployed, you now get the `"rq=.."` value added to the output when the value is available.
If you do not see the `"rq=.."` value in logging out, double check you have added the new header in the nginx config.
  

### Bonus feature: compact exception logging

Add the following to your `config/initializers/lograge.rb` file:

``` ruby
  config.lograge.custom_options = lambda do |event|
    LogrageRailsRequestQueuing::ExceptionDetails.add_any_exception!(
      event, custom_options
    )

    # ... see above ...
  end

  # Adding this removes the verbose exception output in the Rails log:
  ActionDispatch::DebugExceptions.prepend(
    LogrageRailsRequestQueuing::SilenceExceptionLogging
  )
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rud/lograge_rails_request_queuing. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LogrageRailsRequestQueuing project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rud/lograge_rails_request_queuing/blob/master/CODE_OF_CONDUCT.md).
