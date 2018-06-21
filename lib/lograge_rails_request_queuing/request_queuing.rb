# frozen_string_literal: true

module LogrageRailsRequestQueuing
  class RequestQueueing
    # How long was the request queued for, in milliseconds
    attr_reader :queued_ms

    def initialize(env, request_started_at = Time.now.to_f)
      request_received_at = incoming_timestamp(env)
      if request_received_at
        @queued_ms = (request_started_at - request_received_at) * 1000
      end
    end

    private

    def incoming_timestamp(env)
      request_start = env['HTTP_X_REQUEST_START']
      return nil if request_start.blank?

       # convert "t=1529578997.145" to a Float:
      Float(Regexp.last_match(1)) if request_start =~ /t=([.\d+]+)/
    end
  end
end
