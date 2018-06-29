class EchosController < ApplicationController
  def index
    render json: {
      request_queued_raw: RequestStore[:lograge_request_queueing].request_queued_raw,
      queued_ms: RequestStore[:lograge_request_queueing].queued_ms
    }
  end

end
