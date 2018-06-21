# frozen_string_literal: true
require 'rails/engine'

module LogrageRailsRequestQueuing
  # Hook into Rails loading
  class Engine < ::Rails::Engine
    isolate_namespace LogrageRailsRequestQueuing

    config.eager_load_paths += %W[#{config.root}/lib]

    initializer 'lograge_rails_request_queuing.add_timing_middleware' do |app|
      app.middleware.use LogrageRailsRequestQueuing::RequestStartedMiddleware
    end
  end
end
