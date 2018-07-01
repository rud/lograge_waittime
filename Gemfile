# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in lograge_rails_request_queuing.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

# Let CI change the current Rails version using just an environment variable:
rails_version = ENV['RAILS_VERSION'] || 'default'
gem 'rails', case rails_version
             when 'default'
               '~> 5.2.0'
             else
               "~> #{rails_version}"
end


gem 'puma'
