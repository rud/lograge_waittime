class EchosController < ApplicationController
  def index
    raise ArgumentError, "Insufficient mittens" if params[:demo_raise]
    render json: {
      request_queued_raw: ::LogrageWaittime::RequestQueuingStore.request_waittime.request_queued_raw,
      queued_ms: ::LogrageWaittime::RequestQueuingStore.request_waittime.queued_ms
    }
  end
end
