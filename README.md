# `lograge_waittime`

[![Ruby](https://github.com/rud/lograge_waittime/actions/workflows/ruby.yml/badge.svg)](https://github.com/rud/lograge_waittime/actions/workflows/ruby.yml)

[Lograge](https://github.com/roidrage/lograge) makes Rails logging output a lot more more useful.

The log output for a request looks something like this:

```
status=200 duration=58.33 view=40.43 db=15.26 controller=WelcomeController action=show
```

This gem adds another field with how long the request waited to be processed, since arriving in the request queue in NGINX.
The unit is milliseconds, and represented as the `wait` value:

```
status=200 duration=58.33 view=40.43 db=15.26 wait=3.14 controller=WelcomeController action=show
```

Wait time or request queueing time is the time that passes between a request is received in the webserver (typically NGINX), and until it hits the Rails stack in a web worker.

Under normal load in production this value will be in the order of a few milliseconds.
However, if all Rails web-processes are busy, the number will quickly climb as individual requests are queued and waiting to be served.

It's one of the key numbers that are good to keep an eye on in monitoring and is very helpful to include when graphing response times over time.
Long wait times will feel like a sluggish site for end users, and even though you may be seeing short durations to process requests, if the wait-time is large, then the end-user experience will still be bad.

## Docker demo setup

To quickly get a feel for the parts of the setup, a `docker-compose` sample configuration is included.
The setup is fairly simple: requests first hit an NGINX instance, then they are forwarded to the Rails app.
By looking at the log-output you can observe the request queueing time for each request as `wait`.

Try it out by running:

```
docker-compose up
```

Then you can visit [http://localhost:3030/echo](http://localhost:3030/echo) and you will now see the live `wait=` output in the Rails log, like this:

```
method=GET path=/echo format=html controller=EchosController action=index status=200 duration=1.67 view=0.37 wait=1067.24
```

This particular example was the first request to a backend not yet fully started.
This next request was through a warmed up stack:

```
method=GET path=/echo format=html controller=EchosController action=index status=200 duration=0.60 view=0.28 wait=14.37
```

## Installation

### NGINX change

In your NGINX config, add:
```
proxy_set_header X-Request-Start "t=${msec}";
```
to the relevant part of your server setup. According to [NGINX docs](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_set_header), it can go in one of `http`, `server`, or `location`.

This adds a new header to all incoming requests, with current time in milliseconds as the value.
`msec` is supported from NGINX releases 1.2.6 and 1.3.9.

### Rails app changes:

Execute:

``` shell
bundle add lograge_waittime
```

Then add it to your existing lograge initializer, typically in `config/initializers/lograge.rb`.
If you are just setting up lograge, please check that projects documentation for up to date information.

``` ruby
Rails.application.configure do
  config.lograge.enabled = true

  # Keep emitting the verbose logging for easier debug
  config.lograge.keep_original_rails_log = !Rails.env.production?

  config.lograge.custom_options = lambda do |event|
    custom_options = {}

    # lograge_waittime setup:
    queued_ms = RequestStore[:lograge_waittime].queued_ms
    custom_options[:wait] = queued_ms.round(2) if queued_ms

    custom_options
  end
end
```

After this is deployed, you now get the `"wait=.."` value added to the output when the value is available.
If you do not see the `"wait=.."` value in logging out, please double check you have added the new header in your NGINX config and deployed it.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests.

If you want to test using a specific Rails version locally, use this method:

``` shell-interaction
export RAILS_VERSION="~> 5.1" 
bundle update
bundle exec rake
```

If you prefer a oneliner for testing a combination, try this:
```
(asdf shell ruby 2.7.6; export RAILS_VERSION="~> 5.1.0"; rm Gemfile.lock; bundle install; bundle exec rake ci)
(asdf shell ruby 2.7.6; export RAILS_VERSION="~> 6.0.0"; rm Gemfile.lock; bundle install; bundle exec rake ci)
(asdf shell ruby 2.7.6; export RAILS_VERSION="~> 6.1.0"; rm Gemfile.lock; bundle install; bundle exec rake ci)
(asdf shell ruby 3.0.4; export RAILS_VERSION="~> 6.1.0"; rm Gemfile.lock; bundle install; bundle exec rake ci)
(asdf shell ruby 3.0.4; export RAILS_VERSION="~> 7.0.0"; rm Gemfile.lock; bundle install; bundle exec rake ci)
(asdf shell ruby 3.1.2; export RAILS_VERSION="~> 7.0.0"; rm Gemfile.lock; bundle install; bundle exec rake ci)
(asdf shell ruby 3.2.0; export RAILS_VERSION="~> 7.0.0"; rm Gemfile.lock; bundle install; bundle exec rake ci)
```

It assumes you have [`asdf`](https://asdf-vm.com/) installed to manage your ruby versions, which is very convenient.


To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rud/lograge_rails_request_queuing. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LogrageRailsRequestQueuing project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rud/lograge_rails_request_queuing/blob/master/CODE_OF_CONDUCT.md).

## Historical note

Until 2022-11 this gem was called [lograge_rails_request_queuing](https://rubygems.org/gems/lograge_rails_request_queuing).
It was renamed to make it easier to talk about.
