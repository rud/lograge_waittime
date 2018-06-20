$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "lograge_rails_request_queuing/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lograge_rails_request_queuing"
  s.version     = LogrageRailsRequestQueuing::VERSION
  s.authors     = ["Laust Rud Jacobsen"]
  s.email       = ["laust@valuestream.io"]
  s.summary     = 'Add request queueing time to lograge output.'
  s.homepage    = 'https://github.com/rud/lograge_rails_request_queuing'
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency 'lograge'
end
