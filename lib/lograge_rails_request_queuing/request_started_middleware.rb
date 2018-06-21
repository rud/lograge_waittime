# frozen_string_literal: true

module LogrageRailsRequestQueuing
  # Track at what time the request handling starts
  class RequestStartedMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      require 'lograge_rails_request_queuing/request_queuing'

      RequestStore[:lograge_request_queueing] = RequestQueueing.new(env)
      @app.call env
    end
  end
end
