require 'rails/engine'

module Lograge
  module Waittime
    # Hook into Rails loading
    class Engine < ::Rails::Engine
      isolate_namespace Lograge::Waittime

      config.eager_load_paths += %W[#{config.root}/lib]

      initializer 'lograge.add_waittime_middleware' do |app|
        app.middleware.use Lograge::Waittime::RequestStartedMiddleware
      end
    end
  end
end