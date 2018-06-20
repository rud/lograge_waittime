# frozen_string_literal: true

module LogrageRailsRequestQueuing
  class RequestStartedMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call env
    end
  end
end
