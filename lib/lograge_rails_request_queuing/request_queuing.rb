# frozen_string_literal: true

module LogrageRailsRequestQueuing
  class RequestQueueing
    # How long was the request queued for, in milliseconds
    attr_reader :queued_ms

    def initialize(env, request_started_at = Time.now.to_f)
      request_received_at = incoming_timestamp(env)
      @queued_ms = calculate_queued_ms(request_received_at, request_started_at)
    end

    private

    def calculate_queued_ms(request_received_at, request_started_at)
      return if request_received_at.blank?

      waiting_interval_secs = request_started_at - request_received_at
      return if waiting_interval_secs < 0 # clocks out of alignment

      waiting_interval_secs * 1000
    end

    def incoming_timestamp(env)
      request_start = env['HTTP_X_REQUEST_START']
      return nil if request_start.blank?

       # convert "t=1529578997.145" to a Float:
      Float(Regexp.last_match(1)) if request_start =~ /t=([.\d+]+)/
    end
  end
end
