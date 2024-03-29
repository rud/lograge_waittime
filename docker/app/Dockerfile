# Base image:
FROM ruby:2.7

MAINTAINER Laust Rud Jacobsen <laust@valuestream.io>

# Add yarn
RUN apt-get update && apt-get install -y apt-transport-https
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get install -y yarn

# Create application directory
RUN mkdir -p /myapp/lib/lograge_rails_request_queuing

# Copy in only the files "bundle install" needs to run
ADD lograge_waittime.gemspec /myapp/lograge_waittime.gemspec
ADD lib/lograge_waittime/version.rb /myapp/lib/lograge_waittime/version.rb
ADD Gemfile* /myapp/

# Set our working directory inside the image
WORKDIR /myapp

# Run bundle install before copying in the rest of the app
RUN gem install bundler:2.3.25; \
    bundle config set without 'development test'; \
    bundle install --jobs 4 --retry 5

# Time to add the rest of the app
ADD . /myapp

# Switch to the dummy app:
WORKDIR /myapp/test/dummy

EXPOSE 3000

CMD [ "bundle", "exec", "puma", "-C", "config/puma.rb" ]
