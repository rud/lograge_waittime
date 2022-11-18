# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "lograge_waittime/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "lograge_waittime"
  s.version = LogrageWaittime::VERSION
  s.authors = ["Laust Rud Jacobsen"]
  s.email = ["laust@valuestream.io"]
  s.summary = "Add webserver request queueing time to lograge output."
  s.homepage = "https://github.com/rud/lograge_waittime"
  s.license = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "CHANGELOG.md",
    "CODE_OF_CONDUCT.md", "Rakefile", "README.md"]

  s.add_dependency "lograge", "~> 0.10"
  s.add_dependency "request_store", "~> 1.0"
  s.add_dependency "railties", ">= 5.0" # Need access to Rails::Engine API
end
