class EchosController < ApplicationController
  def index
    render json: {
      queued_ms: RequestStore[:lograge_request_queueing].queued_ms
    }
  end

end
