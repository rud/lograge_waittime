# Base image:
FROM ruby:2.5.1

MAINTAINER Laust Rud Jacobsen <laust@valuestream.io>

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - nodejs: Compile assets
# - libpq-dev: Communicate with postgres through the postgres gem
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# create application directory
RUN mkdir -p /myapp/lib/lograge_rails_request_queuing

ADD lograge_rails_request_queuing.gemspec /myapp/lograge_rails_request_queuing.gemspec
ADD lib/lograge_rails_request_queuing/version.rb /myapp/lib/lograge_rails_request_queuing/version.rb
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock

# Set our working directory inside the image
WORKDIR /myapp

# Run bundle install before copying in the rest of the app
RUN bundle install --jobs 20 --retry 5 --without development test

# Time to add the rest of the app
ADD . /myapp

# Switch to the dummy app:
WORKDIR /myapp/test/dummy

EXPOSE 3000

CMD [ "bundle", "exec", "puma", "-C", "config/puma.rb" ]
