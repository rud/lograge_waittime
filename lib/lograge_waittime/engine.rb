# frozen_string_literal: true

module LogrageWaittime
  # Hook into Rails loading
  class Engine < ::Rails::Engine
    isolate_namespace LogrageWaittime

    config.autoload_once_paths << File.expand_path("lib", __dir__)

    initializer "lograge_waittime.add_waittime_middleware" do |app|
      app.middleware.insert_after Rack::Runtime, LogrageWaittime::RequestStartedMiddleware
    end
  end
end
