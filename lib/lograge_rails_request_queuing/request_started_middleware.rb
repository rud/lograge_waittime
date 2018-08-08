# frozen_string_literal: true

require 'lograge_rails_request_queuing/request_queuing'

module LogrageRailsRequestQueuing
  # Track at what time the request handling starts
  class RequestStartedMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      RequestStore[:lograge_request_queueing] = LogrageRailsRequestQueuing::RequestQueueing.new(env)
      @app.call env
    end
  end
end
