require 'lograge/waittime/request_queuing'

module Lograge
  module Waittime
    # Track at what time the request handling starts
    class RequestStartedMiddleware
      def initialize(app)
        @app = app
      end

      def call(env)
        ::RequestStore[:lograge_waittime] = Lograge::Waittime::RequestQueueing.new(env)
        @app.call env
      end
    end
  end
end