# frozen_string_literal: true

module LogrageRailsRequestQueuing
  class RequestQueueing
    # How long was the request queued for, in milliseconds
    attr_reader :queued_ms
    attr_reader :request_started_at, :request_queued_raw

    REQUEST_START_HEADER = 'HTTP_X_REQUEST_START'
    EARLIEST_REQUEST_DATE = Time.new(2000)

    def initialize(env, request_started_at = Time.now.to_f)
      @request_queued_raw = request_start_header(env)
      @request_started_at = request_started_at
      @queued_ms = calculate_queued_ms
    end

    def request_queued_at
      @request_queued_at ||= begin
        [1000, 1].each do |divisor|
          adjusted = Time.at(request_queued_float / divisor)
          return adjusted if adjusted > EARLIEST_REQUEST_DATE
        end
      end
    end

    private

    def calculate_queued_ms
      return if request_queued_at.blank?

      waiting_interval_secs = request_started_at - request_queued_at.to_f
      return if waiting_interval_secs < 0 # clocks out of alignment

      waiting_interval_secs * 1000
    end

    def request_queued_float
      return nil if request_queued_raw.blank?

      # convert values of the form:
      #   "t=1529578997.145"
      #     "1529578997145"
      # to a Float:

      if request_queued_raw =~ /(t=)?([.\d+]+)/
        Float(Regexp.last_match(2))
      end
    end

    def request_start_header(env)
      env[REQUEST_START_HEADER]
    end
  end
end
