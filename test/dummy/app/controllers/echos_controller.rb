class EchosController < ApplicationController
  def index
    render json: {
      lograge_request_handling_started: RequestStore[:lograge_request_handling_started],
      X_REQUEST_START: request.env['HTTP_X_REQUEST_START']
    }
  end

end
