source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in lograge_waittime.gemspec.
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
rails_version = ENV["RAILS_VERSION"] || "~> 6.0.0"
gem "rails", rails_version

gem "lograge"
gem "puma"
gem "standard"

group :development, :test do
  gem "pry", "~> 0.11"
  gem "simplecov", require: false
end
