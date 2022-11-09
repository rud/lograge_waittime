class EchosController < ApplicationController
  def index
    raise ArgumentError, "Insufficient mittens" if params[:demo_raise]
    render json: {
      request_queued_raw: RequestStore[:lograge_waittime].request_queued_raw,
      queued_ms: RequestStore[:lograge_waittime].queued_ms
    }
  end
end
