module LogrageWaittime
  # Track at what time the request handling starts
  class RequestStartedMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      ::RequestStore[:lograge_waittime] = ::LogrageWaittime::RequestQueuing.new(env)
      @app.call env
    end
  end
end
