# frozen_string_literal: true

module LogrageRailsRequestQueuing
  # Track at what time the request handling starts
  class RequestStartedMiddleware
    def initialize(app)
      @app = app
    end

    def call(env, now = Time.now)
      RequestStore[:lograge_request_handling_started] = now
      @app.call env
    end
  end
end
