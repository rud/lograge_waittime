# Base image:
FROM ruby:2.5.1

MAINTAINER Laust Rud Jacobsen <laust@valuestream.io>

# Create application directory
RUN mkdir -p /myapp/lib/lograge_rails_request_queuing

# Copy in only the files "bundle install" needs to run
ADD lograge_rails_request_queuing.gemspec /myapp/lograge_rails_request_queuing.gemspec
ADD lib/lograge_rails_request_queuing/version.rb /myapp/lib/lograge_rails_request_queuing/version.rb
ADD Gemfile* /myapp/

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
