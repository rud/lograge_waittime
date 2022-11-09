# frozen_string_literal: true

if ENV["COVERAGE"]
  # Setup coverage loading as early as possible
  require "simplecov"
  SimpleCov.start do
    add_filter %r{^/test/}
  end
end

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
require "rails/test_help"
require "minitest/autorun"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# require 'rails/test_unit/reporter'
# Rails::TestUnitReporter.executable = 'bin/test'
