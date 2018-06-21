class EchosController < ApplicationController
  def index
    nginx_request_start = request.env['HTTP_X_REQUEST_START']
    if nginx_request_start.present? && nginx_request_start =~ /t=([\.\d+]+)/
      timestamp = Float($1)
      queue_time_seconds = RequestStore[:lograge_request_handling_started].to_f - timestamp
    end


    render json: {
      lograge_request_handling_started: RequestStore[:lograge_request_handling_started],
      lograge_request_handling_started_f: RequestStore[:lograge_request_handling_started].to_f.to_s,
      HTTP_X_REQUEST_START: nginx_request_start,
      queue_time_ms: (queue_time_seconds * 1000).round(2)
    }
  end

end
