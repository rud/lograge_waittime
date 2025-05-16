# frozen_string_literal: true

module LogrageWaittime
  class RequestQueuingStore < ActiveSupport::CurrentAttributes
    attribute :request_waittime
  end
end
